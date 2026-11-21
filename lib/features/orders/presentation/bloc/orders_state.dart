import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';
import 'package:limitless_code_template/features/orders/data/models/orders_response_model.dart';

/// "ترتيب الطلبات" options (current orders only).
enum OrdersSort {
  /// "الأقرب إليك" (default).
  nearest,

  /// "الأحدث إسنادًا".
  newest,

  /// "الأقدم إسنادًا".
  oldest,

  /// "حسب الحالة": at the customer, then on the way, then waiting.
  status,
}

/// Past orders closed on the same `day` ("أمس · 14 نوفمبر").
typedef OrdersDayGroup = ({DateTime day, List<OrderModel> orders});

/// [status] is the current list; [previousStatus] the past list (loaded at
/// the same time).
class OrdersState extends BaseState<OrdersState> {
  const OrdersState({
    super.status,
    super.errorMessage,
    this.tab = OrdersScope.current,
    this.currentOrders,
    this.previousOrders,
    this.previousStatus = AppStatus.initial,
    this.query = '',
    this.sort = OrdersSort.nearest,
    this.isOffline = false,
  });

  final OrdersScope tab;
  final List<OrderModel>? currentOrders;
  final List<OrderModel>? previousOrders;
  final AppStatus previousStatus;

  /// The search text (order number or customer name).
  final String query;
  final OrdersSort sort;

  /// The last failure was a missing connection.
  final bool isOffline;

  bool get isSearching => query.trim().isNotEmpty;

  /// The order being delivered now, pinned on top ("طلبك الحالي"). Hidden
  /// while searching, so it shows up as a normal result.
  OrderModel? get activeOrder {
    if (isSearching) return null;
    for (final order in currentOrders ?? const <OrderModel>[]) {
      if (order.status == OrderStatus.onTheWay ||
          order.status == OrderStatus.arrived) {
        return order;
      }
    }
    return null;
  }

  /// The current list under the pinned card: searched and sorted.
  List<OrderModel> get visibleCurrentOrders {
    final active = activeOrder;
    final orders = [
      for (final order in currentOrders ?? const <OrderModel>[])
        if (order != active && _matches(order)) order,
    ];
    switch (sort) {
      case OrdersSort.nearest:
        orders.sort(
          (a, b) => (a.distanceKm ?? double.infinity).compareTo(
            b.distanceKm ?? double.infinity,
          ),
        );
      case OrdersSort.newest:
        orders.sort((a, b) => b.assignedAt.compareTo(a.assignedAt));
      case OrdersSort.oldest:
        orders.sort((a, b) => a.assignedAt.compareTo(b.assignedAt));
      case OrdersSort.status:
        orders.sort((a, b) => b.status.index.compareTo(a.status.index));
    }
    return orders;
  }

  /// Past orders, searched, newest first.
  List<OrderModel> get visiblePreviousOrders {
    return [
      for (final order in previousOrders ?? const <OrderModel>[])
        if (_matches(order)) order,
    ]..sort(
      (a, b) =>
          (b.closedAt ?? b.assignedAt).compareTo(a.closedAt ?? a.assignedAt),
    );
  }

  /// [visiblePreviousOrders] grouped by the day they were closed.
  List<OrdersDayGroup> get previousGroups {
    final groups = <OrdersDayGroup>[];
    for (final order in visiblePreviousOrders) {
      final at = order.closedAt ?? order.assignedAt;
      final day = DateTime(at.year, at.month, at.day);
      if (groups.isNotEmpty && groups.last.day == day) {
        groups.last.orders.add(order);
      } else {
        groups.add((day: day, orders: [order]));
      }
    }
    return groups;
  }

  /// Matches the order number (with or without `#`/`ORD-`) or the customer
  /// name.
  bool _matches(OrderModel order) {
    final text = query.trim().toLowerCase().replaceAll('#', '');
    if (text.isEmpty) return true;
    return order.code.toLowerCase().contains(text) ||
        order.customerName.toLowerCase().contains(text);
  }

  @override
  OrdersState copyWith({
    AppStatus? status,
    String? errorMessage,
    OrdersScope? tab,
    List<OrderModel>? currentOrders,
    List<OrderModel>? previousOrders,
    AppStatus? previousStatus,
    String? query,
    OrdersSort? sort,
    bool? isOffline,
  }) {
    return OrdersState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      tab: tab ?? this.tab,
      currentOrders: currentOrders ?? this.currentOrders,
      previousOrders: previousOrders ?? this.previousOrders,
      previousStatus: previousStatus ?? this.previousStatus,
      query: query ?? this.query,
      sort: sort ?? this.sort,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    tab,
    currentOrders,
    previousOrders,
    previousStatus,
    query,
    sort,
    isOffline,
  ];
}
