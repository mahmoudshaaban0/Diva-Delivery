import 'package:limitless_code_template/features/orders/data/models/order_model.dart';

/// Which list to load: "الحالية" or "السابقة".
enum OrdersScope { current, previous }

/// The orders list (Figma Flow 03 "الطلبات").
///
/// NOTE: assumed payload until the API contract is shared:
/// `{"orders": [<OrderModel>, …]}`. No paging yet: past orders come back in
/// one list.
class OrdersResponseModel {
  const OrdersResponseModel({required this.orders});

  OrdersResponseModel.fromJson(Map<String, dynamic> json)
    : orders = [
        for (final item in json['orders'] as List<dynamic>? ?? <dynamic>[])
          OrderModel.fromJson(item as Map<String, dynamic>),
      ];

  final List<OrderModel> orders;
}
