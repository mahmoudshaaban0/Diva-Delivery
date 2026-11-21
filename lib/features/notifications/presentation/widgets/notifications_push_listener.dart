import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_push_banner.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/notifications/presentation/bloc/notifications_cubit.dart';
import 'package:limitless_code_template/features/notifications/presentation/bloc/notifications_state.dart';

/// Loads the notifications for the home bell's dot and shows each one that
/// arrives while the app is open as the in-app banner (Figma "إشعار داخل
/// التطبيق"). Tapping the banner opens the order, or the notifications
/// screen. Wraps the tab shell (`MainShell`).
class NotificationsPushListener extends StatefulWidget {
  const NotificationsPushListener({required this.child, super.key});

  final Widget child;

  @override
  State<NotificationsPushListener> createState() =>
      _NotificationsPushListenerState();
}

class _NotificationsPushListenerState extends State<NotificationsPushListener> {
  late final NotificationsCubit _cubit = context.read<NotificationsCubit>();

  @override
  void initState() {
    super.initState();
    if (_cubit.state.notifications == null) unawaited(_cubit.load());
    _cubit.watchIncoming();
  }

  void _onIncoming(BuildContext context, NotificationsState state) {
    final notification = state.incoming;
    if (notification == null) return;
    showAppPushBanner(
      context: context,
      banner: AppPushBanner(
        iconAsset: Assets.vectorsIcPackage20,
        title: notification.title,
        body: notification.body,
        time: context.localizations.timeNow,
      ),
      onTap: () {
        unawaited(_cubit.markRead(notification));
        final orderId = notification.orderId;
        unawaited(
          orderId == null
              ? context.pushNamed(AppRoutes.notifications.name)
              : context.pushNamed(
                  AppRoutes.orderDetails.name,
                  pathParameters: {'id': orderId},
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsCubit, NotificationsState>(
      listenWhen: (previous, current) =>
          current.incoming != null && previous.incoming != current.incoming,
      listener: _onIncoming,
      child: widget.child,
    );
  }
}
