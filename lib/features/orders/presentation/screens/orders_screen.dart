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
    final hasData = state.tab == OrdersScope.current
        ? state.currentOrders != null
        : state.previousOrders != null;
    if (!hasData) return;
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

          return Scaffold(
            backgroundColor: context.colors.surfaceBg,
            body: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppPageHeader(
                    title: context.localizations.ordersTitle,
                    subtitle: isCurrentTab
                        ? current == null
                              ? null
                              : current.isEmpty
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
                      currentCount: current?.length ?? 0,
                      onChanged: _cubit.selectTab,
                    ),
                  ),
                  Expanded(
                    child: isCurrentTab
                        ? OrdersCurrentTab(
                            state: state,
                            onRefresh: _cubit.load,
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
                            onRefresh: _cubit.load,
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
