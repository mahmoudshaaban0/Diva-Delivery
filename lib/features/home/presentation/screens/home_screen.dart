import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_bottom_sheet.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_toast.dart';
import 'package:limitless_code_template/core/design_system/organisms/error_state.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/presentation/bloc/home_cubit.dart';
import 'package:limitless_code_template/features/home/presentation/bloc/home_state.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_announcements.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_day_progress_card.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_day_started_sheet.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_day_status.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_header.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_orders_status_card.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_out_of_range_sheet.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_skeleton.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_start_day_card.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_totals_card.dart';
import 'package:limitless_code_template/features/notifications/presentation/bloc/notifications_cubit.dart';
import 'package:limitless_code_template/features/notifications/presentation/bloc/notifications_state.dart';

/// Figma: Flow 02 · "الرئيسية" (before / checking / after starting the day,
/// no orders) with the "outside the warehouse" and "day started" sheets.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<HomeCubit>();
        unawaited(cubit.getHome());
        return cubit;
      },
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  Future<void> _onStartDayStage(BuildContext context, HomeState state) async {
    final cubit = context.read<HomeCubit>();
    final home = state.home;
    if (home == null) return;

    switch (state.startDayStage) {
      case StartDayStage.outOfRange:
        var retry = false;
        await showAppBottomSheet<void>(
          context: context,
          size: AppSheetSize.wrap,
          child: HomeOutOfRangeSheet(
            warehouseName: home.warehouse.name,
            distanceKm: state.distanceKm,
            onOpenDirections: () =>
                unawaited(cubit.openDirectionsToWarehouse()),
            onTryAgain: () {
              retry = true;
              Navigator.of(context).pop();
            },
          ),
        );
        cubit.resetStartDay();
        if (retry) unawaited(cubit.startDay());
      case StartDayStage.started:
        final result = state.startResult;
        if (result == null) return;
        await showAppBottomSheet<void>(
          context: context,
          size: AppSheetSize.wrap,
          child: HomeDayStartedSheet(
            result: result,
            warehouseName: home.warehouse.name,
            onViewOrders: () {
              Navigator.of(context).pop();
              context.goNamed(AppRoutes.orders.name);
            },
            onLater: () => Navigator.of(context).pop(),
          ),
        );
        cubit.resetStartDay();
      case StartDayStage.failed:
        context.showToast(
          message: state.isLocationUnavailable
              ? context.localizations.locationUnavailable
              : state.isOffline
              ? context.localizations.noInternetConnection
              : state.errorMessage ?? context.localizations.homeLoadError,
          iconAsset: state.isOffline ? Assets.vectorsIcWifiOff20 : null,
          actionLabel: context.localizations.retry,
          onAction: () => unawaited(cubit.startDay()),
        );
        cubit.resetStartDay();
      case StartDayStage.idle:
      case StartDayStage.checking:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (a, b) => a.startDayStage != b.startDayStage,
      listener: (context, state) => unawaited(_onStartDayStage(context, state)),
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final home = state.home;

        return Scaffold(
          backgroundColor: context.colors.surfaceBg,
          body: SafeArea(
            bottom: false,
            child: home == null
                ? state.status == AppStatus.failure
                      ? ErrorState(
                          message: state.isOffline
                              ? context.localizations.noInternetConnection
                              : context.localizations.homeLoadError,
                          retryLabel: context.localizations.retry,
                          onRetry: () => unawaited(cubit.getHome()),
                        )
                      : const HomeSkeleton()
                : RefreshIndicator.adaptive(
                    onRefresh: cubit.getHome,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: AppInsets.only(
                        start: 20,
                        end: 20,
                        top: 8,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocSelector<
                            NotificationsCubit,
                            NotificationsState,
                            bool
                          >(
                            selector: (state) => state.unreadCount > 0,
                            builder: (context, hasUnread) => HomeHeader(
                              name: home.courierName,
                              area: home.area,
                              hasUnreadNotifications: hasUnread,
                              onNotifications: () => unawaited(
                                context.pushNamed(AppRoutes.notifications.name),
                              ),
                            ),
                          ),
                          gapH20,
                          HomeDayStatus(startedAt: home.dayStartedAt),
                          gapH20,
                          HomeTotalsCard(
                            totalOrders: home.totalOrders,
                            totalCollected: home.totalCollected,
                          ),
                          gapH16,
                          HomeOrdersStatusCard(
                            pending: home.pendingOrders,
                            completed: home.completedOrders,
                            cancelled: home.cancelledOrders,
                            isDayStarted: home.isDayStarted,
                          ),
                          if (home.announcements.isNotEmpty) ...[
                            gapH20,
                            HomeAnnouncements(
                              announcements: home.announcements,
                            ),
                          ],
                          gapH12,
                          if (home.isDayStarted)
                            HomeDayProgressCard(
                              delivered: home.deliveredToday,
                              assigned: home.assignedToday,
                              onViewOrders: () =>
                                  context.goNamed(AppRoutes.orders.name),
                            )
                          else
                            HomeStartDayCard(
                              warehouseName: home.warehouse.name,
                              isInRange: state.isInWarehouseRange,
                              hasOrders: home.pendingOrders > 0,
                              isChecking:
                                  state.startDayStage == StartDayStage.checking,
                              onSwiped: () => unawaited(cubit.startDay()),
                            ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
