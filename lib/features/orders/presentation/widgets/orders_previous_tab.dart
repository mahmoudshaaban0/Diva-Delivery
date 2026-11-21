import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_load_error_view.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_status_view.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';
import 'package:limitless_code_template/features/orders/data/models/orders_response_model.dart';
import 'package:limitless_code_template/features/orders/presentation/bloc/orders_state.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_card.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_day_label.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_section_label.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_skeleton.dart';

/// Body of the "السابقة" tab: past orders grouped by day ("أمس · 14
/// نوفمبر"), or one flat list of results while searching.
class OrdersPreviousTab extends StatelessWidget {
  const OrdersPreviousTab({
    required this.state,
    required this.onRefresh,
    required this.onContactSupport,
    required this.onClearSearch,
    required this.onOpen,
    this.banner,
    super.key,
  });

  final OrdersState state;
  final Future<void> Function() onRefresh;
  final VoidCallback onContactSupport;

  /// The connection banner, shown above the list (Flow 08).
  final Widget? banner;
  final VoidCallback onClearSearch;
  final ValueChanged<OrderModel> onOpen;

  @override
  Widget build(BuildContext context) {
    final orders = state.previousOrders;
    if (orders == null) {
      return state.previousStatus == AppStatus.failure
          ? AppLoadErrorView(
              isOffline: state.isOffline,
              offlineMessage: context.localizations.ordersOfflineMessage,
              onRetry: onRefresh,
              onContactSupport: onContactSupport,
            )
          : const OrdersSkeleton();
    }

    if (orders.isEmpty) {
      return AppStatusView(
        iconAsset: Assets.vectorsIcPackage26,
        title: context.localizations.ordersPreviousEmptyTitle,
        message: context.localizations.ordersPreviousEmptyMessage,
      );
    }

    final results = state.visiblePreviousOrders;
    if (state.isSearching && results.isEmpty) {
      return AppStatusView(
        iconAsset: Assets.vectorsIcSearch26,
        title: context.localizations.ordersNoResultsTitle,
        message: context.localizations.ordersNoResultsMessage(
          state.query.trim(),
        ),
        actionLabel: context.localizations.ordersClearSearch,
        onAction: onClearSearch,
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: context.colors.brandPrimary,
      child: ListView(
        padding: AppInsets.only(start: 20, end: 20, top: 16, bottom: 24),
        children: [
          ?banner,
          if (state.isSearching) ...[
            OrdersSectionLabel(
              context.localizations.ordersSearchResults(
                results.length,
                OrdersScope.previous.name,
              ),
            ),
            for (final order in results) ...[
              10.vs,
              OrderCard(order: order, onTap: () => onOpen(order)),
            ],
          ] else
            for (final (index, group) in state.previousGroups.indexed) ...[
              if (index > 0) gapH20,
              OrdersDayLabel(day: group.day),
              for (final order in group.orders) ...[
                10.vs,
                OrderCard(order: order, onTap: () => onOpen(order)),
              ],
            ],
        ],
      ),
    );
  }
}
