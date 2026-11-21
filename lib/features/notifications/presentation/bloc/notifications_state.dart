import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/features/notifications/data/models/notification_model.dart';

/// "الكل · الطلبات · التحصيل · التنبيهات".
enum NotificationsFilter { all, orders, collection, alerts }

/// Notifications received on the same `day` ("اليوم", "أمس").
typedef NotificationsDayGroup = ({
  DateTime day,
  List<NotificationModel> notifications,
});

class NotificationsState extends BaseState<NotificationsState> {
  const NotificationsState({
    super.status,
    super.errorMessage,
    this.notifications,
    this.filter = NotificationsFilter.all,
    this.incoming,
    this.isOffline = false,
    this.markAllStatus = AppStatus.initial,
  });

  /// Newest first; null until loaded.
  final List<NotificationModel>? notifications;
  final NotificationsFilter filter;

  /// The last notification that arrived while the app was open (shown as
  /// the in-app banner).
  final NotificationModel? incoming;

  /// The last failure was a missing connection.
  final bool isOffline;

  /// "تعليم الكل كمقروء" (a failure reverts and shows a toast).
  final AppStatus markAllStatus;

  /// The red dot on the home bell.
  int get unreadCount => [
    for (final n in notifications ?? const <NotificationModel>[])
      if (!n.isRead) n,
  ].length;

  /// [notifications] matching [filter], grouped by day.
  List<NotificationsDayGroup> get visibleGroups {
    final groups = <NotificationsDayGroup>[];
    for (final notification in notifications ?? const <NotificationModel>[]) {
      final matches = switch (filter) {
        NotificationsFilter.all => true,
        NotificationsFilter.orders =>
          notification.type.category == NotificationCategory.orders,
        NotificationsFilter.collection =>
          notification.type.category == NotificationCategory.collection,
        NotificationsFilter.alerts =>
          notification.type.category == NotificationCategory.alerts,
      };
      if (!matches) continue;
      final at = notification.createdAt;
      final day = DateTime(at.year, at.month, at.day);
      if (groups.isNotEmpty && groups.last.day == day) {
        groups.last.notifications.add(notification);
      } else {
        groups.add((day: day, notifications: [notification]));
      }
    }
    return groups;
  }

  @override
  NotificationsState copyWith({
    AppStatus? status,
    String? errorMessage,
    List<NotificationModel>? notifications,
    NotificationsFilter? filter,
    NotificationModel? incoming,
    bool? isOffline,
    AppStatus? markAllStatus,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      notifications: notifications ?? this.notifications,
      filter: filter ?? this.filter,
      incoming: incoming ?? this.incoming,
      isOffline: isOffline ?? this.isOffline,
      markAllStatus: markAllStatus ?? this.markAllStatus,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    notifications,
    filter,
    incoming,
    isOffline,
    markAllStatus,
  ];
}
