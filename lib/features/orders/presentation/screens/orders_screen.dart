import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_circle_icon_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_search_bar.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_bottom_sheet.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_connection_banner.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_page_header.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_toast.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/formatters/date_formatter.dart';
import 'package:limitless_code_template/core/formatters/western_digits_formatter.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';
import 'package:limitless_code_template/features/orders/data/models/orders_response_model.dart';
import 'package:limitless_code_template/features/orders/presentation/bloc/orders_cubit.dart';
import 'package:limitless_code_template/features/orders/presentation/bloc/orders_state.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_current_tab.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_previous_tab.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_sort_sheet.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_tabs.dart';

/// Figma: Flow 03 · "قائمة الطلبات" (orders tab): current and past orders,
/// search, the "ترتيب الطلبات" sheet, and the empty / no-results states.
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersCubit _cubit = getIt<OrdersCubit>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    unawaited(_cubit.load());
  }

  @override
  void dispose() {
    _searchController.dispose();
    unawaited(_cubit.close());
    super.dispose();
  }

  Future<void> _onSort() async {
    final sort = await showAppBottomSheet<OrdersSort>(
      context: context,
      size: AppSheetSize.wrap,
      child: OrdersSortSheet(initial: _cubit.state.sort),
    );
    if (sort != null) _cubit.sortBy(sort);
  }

  /// NOTE: the support channel isn't decided yet (same as the profile's
  /// "الدعم والمساعدة").
  void _onContactSupport() {
    context.showToast(message: context.localizations.comingSoon);
  }

  void _onClearSearch() {
    _searchController.clear();
    _cubit.search('');
  }

  void _onOpen(OrderModel order) {
    unawaited(
      context.pushNamed(
        AppRoutes.orderDetails.name,
        pathParameters: {'id': order.id},
        extra: order,
      ),
    );
  }

  Future<void> _onNavigate(OrderModel order) async {
    final opened = await _cubit.navigateTo(order);
    if (!opened && mounted) {
      context.showToast(message: context.localizations.mapsFailed);
    }
  }

  Future<void> _onCall(OrderModel order) async {
    final called = await _cubit.callCustomer(order);
    if (!called && mounted) {
      context.showToast(message: context.localizations.callFailed);
    }
  }

  /// A refresh that failed while a list is already on screen: keep the list
  /// and say why in a toast (with no data, the tab shows the error state).
  void _onRefreshFailed(BuildContext context, OrdersState state) {
    // Only the visible tab's list, and only if it was already on screen.
    final visibleListFailed = state.tab == OrdersScope.current
        ? state.status == AppStatus.failure && state.currentOrders != null
        : state.previousStatus == AppStatus.failure &&
              state.previousOrders != null;
    if (!visibleListFailed) return;
    context.showToast(
      message: state.isOffline
          ? context.localizations.noInternetConnection
          : context.localizations.ordersLoadError,
      iconAsset: state.isOffline ? Assets.vectorsIcWifiOff20 : null,
      actionLabel: context.localizations.retry,
      onAction: () => unawaited(_cubit.load()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<OrdersCubit, OrdersState>(
        listenWhen: (previous, current) =>
            (previous.status != current.status &&
                current.status == AppStatus.failure) ||
            (previous.previousStatus != current.previousStatus &&
                current.previousStatus == AppStatus.failure),
        listener: _onRefreshFailed,
        builder: (context, state) {
          final current = state.currentOrders;
          final previous = state.previousOrders;
          final isCurrentTab = state.tab == OrdersScope.current;
          final cachedAt = state.cachedAt;
          // Until the first list arrives (loading, or failed with nothing
          // saved) the header is just the title, like the design.
          final isFirstLoad = current == null;
          final banner = AppConnectionBanner(
            status: state.connection,
            bottomSpacing: 20,
            message: state.connection == AppConnectionStatus.offline
                ? context.localizations.ordersOfflineBanner(
                    cachedAt == null ? '' : DateFormatter.formatTime(cachedAt),
                  )
                : context.localizations.connectionRestored,
          );

          return Scaffold(
            backgroundColor: context.colors.surfaceBg,
            body: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isFirstLoad)
                    AppPageHeader(
                      title: context.localizations.ordersTitle,
                      subtitle: state.status == AppStatus.failure
                          ? null
                          : context.localizations.ordersLoadingSubtitle,
                    )
                  else ...[
                    AppPageHeader(
                      title: context.localizations.ordersTitle,
                      subtitle: isCurrentTab
                          ? current.isEmpty
                                ? context.localizations.ordersNoCurrentSubtitle
                                : context.localizations.ordersCurrentSubtitle(
                                    current.length,
                                    DateFormatter.formatWeekdayDayMonth(
                                      DateTime.now(),
                                    ),
                                  )
                          : previous == null
                          ? null
                          : context.localizations.ordersPreviousSubtitle(
                              previous.length,
                            ),
                      // Sorting applies to the current orders only.
                      action: isCurrentTab
                          ? AppCircleIconButton(
                              tooltip: context.localizations.ordersSortTitle,
                              onPressed: () => unawaited(_onSort()),
                              icon: AppSvgIcon(
                                Assets.vectorsIcSorting22,
                                size: 22,
                                color: context.colors.textTitle,
                              ),
                            )
                          : null,
                      bottom: AppSearchBar(
                        controller: _searchController,
                        hintText: context.localizations.ordersSearchHint,
                        clearTooltip: context.localizations.ordersClearSearch,
                        inputFormatters: const [WesternDigitsFormatter()],
                        onChanged: _cubit.search,
                      ),
                    ),
                    Padding(
                      padding: AppInsets.only(start: 20, end: 20, top: 16),
                      child: OrdersTabs(
                        selected: state.tab,
                        currentCount: current.length,
                        onChanged: _cubit.selectTab,
                      ),
                    ),
                  ],
                  Expanded(
                    child: isCurrentTab
                        ? OrdersCurrentTab(
                            state: state,
                            banner: banner,
                            onRefresh: _cubit.load,
                            onContactSupport: _onContactSupport,
                            onClearSearch: _onClearSearch,
                            onShowPrevious: () =>
                                _cubit.selectTab(OrdersScope.previous),
                            onOpen: _onOpen,
                            onNavigate: (order) =>
                                unawaited(_onNavigate(order)),
                            onCall: (order) => unawaited(_onCall(order)),
                          )
                        : OrdersPreviousTab(
                            state: state,
                            banner: banner,
                            onRefresh: _cubit.load,
                            onContactSupport: _onContactSupport,
                            onClearSearch: _onClearSearch,
                            onOpen: _onOpen,
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
