import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/features/notifications/data/models/notification_model.dart';
import 'package:limitless_code_template/features/notifications/data/repositories/notifications_repository.dart';
import 'package:limitless_code_template/features/notifications/presentation/bloc/notifications_state.dart';

/// One instance for the whole signed-in app (provided by `MainShell`): the
/// home bell's dot, the "الإشعارات" screen and the in-app banner all read
/// it. Don't close it from a screen.
@lazySingleton
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._notificationsRepository)
    : super(const NotificationsState());

  final NotificationsRepository _notificationsRepository;
  StreamSubscription<NotificationModel>? _incoming;

  Future<void> load() async {
    emit(state.copyWith(status: AppStatus.loading, isOffline: false));
    final result = await _notificationsRepository.getNotifications();
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            status: AppStatus.success,
            notifications: data.notifications,
          ),
        );
      case Error(:final exception):
        emit(
          state.copyWith(
            status: AppStatus.failure,
            isOffline: exception is NoInternetConnectionException,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }

  /// Starts listening for notifications that arrive while the app is open.
  /// Safe to call more than once.
  void watchIncoming() {
    _incoming ??= _notificationsRepository.watchIncoming().listen(
      (notification) => emit(
        state.copyWith(
          incoming: notification,
          notifications: [notification, ...?state.notifications],
        ),
      ),
    );
  }

  void selectFilter(NotificationsFilter filter) =>
      emit(state.copyWith(filter: filter));

  /// Marks it read right away; puts it back if the server refuses.
  Future<void> markRead(NotificationModel notification) async {
    if (notification.isRead) return;
    final before = state.notifications ?? const <NotificationModel>[];
    emit(
      state.copyWith(
        notifications: [
          for (final n in before)
            if (n.id == notification.id) n.copyWith(isRead: true) else n,
        ],
      ),
    );
    final result = await _notificationsRepository.markRead(notification.id);
    switch (result) {
      case Success():
        break;
      case Error():
        emit(state.copyWith(notifications: before));
    }
  }

  /// "تعليم الكل كمقروء": marks everything read right away; on failure puts
  /// the list back and reports it (toast).
  Future<void> markAllRead() async {
    final before = state.notifications ?? const <NotificationModel>[];
    if (state.unreadCount == 0) return;
    emit(
      state.copyWith(
        markAllStatus: AppStatus.loading,
        isOffline: false,
        notifications: [for (final n in before) n.copyWith(isRead: true)],
      ),
    );
    final result = await _notificationsRepository.markAllRead();
    switch (result) {
      case Success():
        emit(state.copyWith(markAllStatus: AppStatus.success));
      case Error(:final exception):
        emit(
          state.copyWith(
            markAllStatus: AppStatus.failure,
            notifications: before,
            isOffline: exception is NoInternetConnectionException,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }

  @override
  Future<void> close() async {
    await _incoming?.cancel();
    await super.close();
  }
}
