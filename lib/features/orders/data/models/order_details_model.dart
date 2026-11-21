import 'package:limitless_code_template/features/orders/data/models/order_model.dart';

/// One product line (Figma `Courier/Product Row`).
class OrderProductModel {
  const OrderProductModel({
    required this.name,
    required this.category,
    required this.quantity,
    required this.unitPrice,
    this.imageUrl,
  });

  OrderProductModel.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String? ?? '',
      category = json['category'] as String? ?? '',
      quantity = (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice = (json['unit_price'] as num?)?.toDouble() ?? 0,
      imageUrl = json['image_url'] as String?;

  final String name;

  /// e.g. "مشروبات".
  final String category;
  final int quantity;
  final double unitPrice;

  /// Product photo; the package icon is shown when null.
  final String? imageUrl;

  double get total => unitPrice * quantity;
}

/// Everything on "تفاصيل الطلب" (Figma Flow 03, current and past).
///
/// NOTE: assumed payload until the API contract is shared: the list fields
/// of `OrderModel` plus
/// ```json
/// {
///   "products": [{"name": "مياه نوفا 330 مل", "category": "مشروبات",
///                 "quantity": 2, "unit_price": 18.0, "image_url": null}],
///   "subtotal": 330.0, "delivery_fee": 15.0,
///   "national_address": "RRRD2929",
///   "home_photo_url": null, "order_photo_url": null
/// }
/// ```
class OrderDetailsModel {
  const OrderDetailsModel({
    required this.order,
    required this.products,
    required this.subtotal,
    required this.deliveryFee,
    this.nationalAddress,
    this.homePhotoUrl,
    this.orderPhotoUrl,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic> json)
    : order = OrderModel.fromJson(json),
      products = [
        for (final item in json['products'] as List<dynamic>? ?? <dynamic>[])
          OrderProductModel.fromJson(item as Map<String, dynamic>),
      ],
      subtotal = (json['subtotal'] as num?)?.toDouble() ?? 0,
      deliveryFee = (json['delivery_fee'] as num?)?.toDouble() ?? 0,
      nationalAddress = json['national_address'] as String?,
      homePhotoUrl = json['home_photo_url'] as String?,
      orderPhotoUrl = json['order_photo_url'] as String?;

  final OrderModel order;
  final List<OrderProductModel> products;
  final double subtotal;
  final double deliveryFee;

  /// Saudi short national address (e.g. `RRRD2929`).
  final String? nationalAddress;

  /// Proof of delivery ("إثبات التسليم"), past delivered orders only.
  final String? homePhotoUrl;
  final String? orderPhotoUrl;

  bool get hasProofOfDelivery => order.status == OrderStatus.delivered;
}
