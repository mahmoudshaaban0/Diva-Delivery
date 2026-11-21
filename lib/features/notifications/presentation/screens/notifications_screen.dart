import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_circle_icon_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_load_error_view.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_page_header.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_status_view.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_toast.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/notifications/data/models/notification_model.dart';
import 'package:limitless_code_template/features/notifications/presentation/bloc/notifications_cubit.dart';
import 'package:limitless_code_template/features/notifications/presentation/bloc/notifications_state.dart';
import 'package:limitless_code_template/features/notifications/presentation/widgets/notification_item.dart';
import 'package:limitless_code_template/features/notifications/presentation/widgets/notifications_day_label.dart';
import 'package:limitless_code_template/features/notifications/presentation/widgets/notifications_filters.dart';
import 'package:limitless_code_template/features/notifications/presentation/widgets/notifications_skeleton.dart';

/// Figma: Flow 08 · "الإشعارات" (with its empty and loading states). An
/// inner screen of the Home tab, so the tab bar stays. Uses the shared
/// `NotificationsCubit` from `MainShell`.
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final NotificationsCubit _cubit = context.read<NotificationsCubit>();

  @override
  void initState() {
    super.initState();
    // Fresh list each time the screen opens.
    unawaited(_cubit.load());
  }

  void _onOpen(NotificationModel notification) {
    unawaited(_cubit.markRead(notification));
    final orderId = notification.orderId;
    if (orderId != null) {
      unawaited(
        context.pushNamed(
          AppRoutes.orderDetails.name,
          pathParameters: {'id': orderId},
        ),
      );
    }
  }

  void _onMarkAllStatus(BuildContext context, NotificationsState state) {
    if (state.markAllStatus != AppStatus.failure) return;
    context.showToast(
      message: state.isOffline
          ? context.localizations.noInternetConnection
          : context.localizations.markAllReadError,
      iconAsset: state.isOffline ? Assets.vectorsIcWifiOff20 : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listenWhen: (previous, current) =>
          previous.markAllStatus != current.markAllStatus,
      listener: _onMarkAllStatus,
      builder: (context, state) {
        final notifications = state.notifications;
        final groups = state.visibleGroups;

        return Scaffold(
          backgroundColor: context.colors.surfaceBg,
          body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppPageHeader(
                  title: context.localizations.notifications,
                  subtitle: notifications == null
                      ? null
                      : context.localizations.notificationsUnread(
                          state.unreadCount,
                        ),
                  onBack: () => context.pop(),
                  action: state.unreadCount == 0
                      ? null
                      : AppCircleIconButton(
                          tooltip: context.localizations.markAllRead,
                          onPressed: () => unawaited(_cubit.markAllRead()),
                          icon: AppSvgIcon(
                            Assets.vectorsIcTickDouble22,
                            size: 22,
                            color: context.colors.textTitle,
                          ),
                        ),
                ),
                Expanded(
                  child: notifications == null
                      ? state.status == AppStatus.failure
                            ? AppLoadErrorView(
                                isOffline: state.isOffline,
                                onRetry: () => unawaited(_cubit.load()),
                                // NOTE: the support channel isn't decided yet.
                                onContactSupport: () => context.showToast(
                                  message: context.localizations.comingSoon,
                                ),
                              )
                            : const NotificationsSkeleton()
                      : notifications.isEmpty
                      ? AppStatusView(
                          size: AppStatusViewSize.compact,
                          iconAsset: Assets.vectorsIcNotification26,
                          title: context.localizations.notificationsEmptyTitle,
                          message:
                              context.localizations.notificationsEmptyMessage,
                        )
                      : RefreshIndicator(
                          onRefresh: _cubit.load,
                          color: context.colors.brandPrimary,
                          child: ListView(
                            padding: AppInsets.only(
                              start: 20,
                              end: 20,
                              top: 13,
                              bottom: 24,
                            ),
                            children: [
                              NotificationsFilters(
                                selected: state.filter,
                                onChanged: _cubit.selectFilter,
                              ),
                              if (groups.isEmpty)
                                SizedBox(
                                  height: 360.h,
                                  child: AppStatusView(
                                    size: AppStatusViewSize.compact,
                                    iconAsset: Assets.vectorsIcNotification26,
                                    title: context
                                        .localizations
                                        .notificationsEmptyTitle,
                                    message: context
                                        .localizations
                                        .notificationsEmptyMessage,
                                  ),
                                ),
                              for (final (index, group) in groups.indexed) ...[
                                if (index == 0) gapH12 else gapH16,
                                NotificationsDayLabel(day: group.day),
                                for (final notification
                                    in group.notifications) ...[
                                  gapH8,
                                  NotificationItem(
                                    notification: notification,
                                    onTap: () => _onOpen(notification),
                                  ),
                                ],
                              ],
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
