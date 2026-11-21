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
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_active_card.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_section_label.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_skeleton.dart';

/// Body of the "الحالية" tab: skeleton → error → "أنهيت طلبات اليوم" →
/// "لا توجد نتائج" → the pinned order and the sorted list.
class OrdersCurrentTab extends StatelessWidget {
  const OrdersCurrentTab({
    required this.state,
    required this.onRefresh,
    required this.onContactSupport,
    required this.onClearSearch,
    required this.onShowPrevious,
    required this.onOpen,
    required this.onNavigate,
    required this.onCall,
    this.banner,
    super.key,
  });

  final OrdersState state;
  final Future<void> Function() onRefresh;
  final VoidCallback onContactSupport;

  /// The connection banner, shown above the list (Flow 08).
  final Widget? banner;
  final VoidCallback onClearSearch;
  final VoidCallback onShowPrevious;
  final ValueChanged<OrderModel> onOpen;
  final ValueChanged<OrderModel> onNavigate;
  final ValueChanged<OrderModel> onCall;

  @override
  Widget build(BuildContext context) {
    final orders = state.currentOrders;
    if (orders == null) {
      return state.status == AppStatus.failure
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
        title: context.localizations.ordersEmptyTitle,
        message: context.localizations.ordersEmptyMessage,
        actionLabel: context.localizations.ordersShowPrevious,
        onAction: onShowPrevious,
      );
    }

    final active = state.activeOrder;
    final visible = state.visibleCurrentOrders;
    if (state.isSearching && visible.isEmpty) {
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
          if (active != null) ...[
            OrdersActiveCard(
              order: active,
              onTap: () => onOpen(active),
              onNavigate: () => onNavigate(active),
              onCall: () => onCall(active),
            ),
            gapH20,
          ],
          if (visible.isNotEmpty)
            OrdersSectionLabel(
              state.isSearching
                  ? context.localizations.ordersSearchResults(
                      visible.length,
                      OrdersScope.current.name,
                    )
                  : active != null
                  ? context.localizations.ordersOthersSorted(state.sort.name)
                  : context.localizations.ordersAllSorted(state.sort.name),
            ),
          for (final order in visible) ...[
            10.vs,
            OrderCard(order: order, onTap: () => onOpen(order)),
          ],
        ],
      ),
    );
  }
}
