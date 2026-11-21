import 'package:limitless_code_template/features/orders/data/models/order_model.dart';

/// Which list to load: "الحالية" or "السابقة".
enum OrdersScope { current, previous }

/// The orders list (Figma Flow 03 "الطلبات").
///
/// NOTE: assumed payload until the API contract is shared:
/// `{"orders": [<OrderModel>, …]}`. No paging yet: past orders come back in
/// one list.
class OrdersResponseModel {
  const OrdersResponseModel({required this.orders, this.cachedAt});

  OrdersResponseModel.fromJson(Map<String, dynamic> json)
    : orders = [
        for (final item in json['orders'] as List<dynamic>? ?? <dynamic>[])
          OrderModel.fromJson(item as Map<String, dynamic>),
      ],
      cachedAt = DateTime.tryParse(json['cached_at'] as String? ?? '');

  final List<OrderModel> orders;

  /// Set when this is the copy saved on the device (offline), to when it
  /// was saved ("آخر بيانات محفوظة 12:40 م"). Null for fresh data.
  final DateTime? cachedAt;

  Map<String, dynamic> toJson() => {
    'orders': [for (final order in orders) order.toJson()],
    'cached_at': cachedAt?.toIso8601String(),
  };
}
