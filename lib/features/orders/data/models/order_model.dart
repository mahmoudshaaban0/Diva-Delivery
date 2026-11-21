/// The courier-facing order status (Figma `Courier/Status Chip`).
enum OrderStatus {
  /// "مع الكابتن": picked up, not started yet.
  withCourier,

  /// "في الطريق": being delivered now.
  onTheWay,

  /// "تم الوصول": at the customer.
  arrived,

  /// "تم التسليم".
  delivered,

  /// "لم يتم الرد": the customer didn't answer.
  noAnswer,

  /// "مرفوض": the customer refused the order.
  rejected;

  /// Still to deliver ("الحالية" tab); the others are "السابقة".
  bool get isCurrent => switch (this) {
    withCourier || onTheWay || arrived => true,
    delivered || noAnswer || rejected => false,
  };

  static OrderStatus fromJson(String? value) => switch (value) {
    'on_the_way' => onTheWay,
    'arrived' => arrived,
    'delivered' => delivered,
    'no_answer' => noAnswer,
    'rejected' => rejected,
    _ => withCourier,
  };
}

/// "أفراد (B2C)" / "شركات (B2B)".
enum CustomerType {
  individual,
  business;

  static CustomerType fromJson(String? value) =>
      value == 'business' ? business : individual;
}

enum PaymentMethod {
  /// "الدفع عند الاستلام": the courier collects the total.
  cashOnDelivery,

  /// Paid online before delivery ("مدفوع").
  prepaid;

  static PaymentMethod fromJson(String? value) =>
      value == 'prepaid' ? prepaid : cashOnDelivery;
}

/// One order in the list (Figma `Courier/Order Card` and `Courier/Next
/// Order Card`).
///
/// NOTE: assumed payload until the API contract is shared:
/// ```json
/// {
///   "id": "10234", "code": "ORD-10234",
///   "customer_name": "أحمد العتيبي", "customer_type": "individual",
///   "phone": "501234567", "district": "حي العليا", "city": "الرياض",
///   "latitude": 24.69, "longitude": 46.68, "distance_km": 1.2,
///   "status": "on_the_way", "assigned_at": "2026-11-15T08:30:00",
///   "closed_at": null, "items_count": 5, "total": 345.0,
///   "payment_method": "cash_on_delivery", "is_paid": false
/// }
/// ```
class OrderModel {
  const OrderModel({
    required this.id,
    required this.code,
    required this.customerName,
    required this.customerType,
    required this.phone,
    required this.district,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.assignedAt,
    required this.itemsCount,
    required this.total,
    required this.paymentMethod,
    this.distanceKm,
    this.closedAt,
    this.isPaid = false,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
    : id = '${json['id'] ?? ''}',
      code = json['code'] as String? ?? '',
      customerName = json['customer_name'] as String? ?? '',
      customerType = CustomerType.fromJson(json['customer_type'] as String?),
      phone = json['phone'] as String? ?? '',
      district = json['district'] as String? ?? '',
      city = json['city'] as String? ?? '',
      latitude = (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude = (json['longitude'] as num?)?.toDouble() ?? 0,
      distanceKm = (json['distance_km'] as num?)?.toDouble(),
      status = OrderStatus.fromJson(json['status'] as String?),
      assignedAt =
          DateTime.tryParse(json['assigned_at'] as String? ?? '') ??
          DateTime.now(),
      closedAt = DateTime.tryParse(json['closed_at'] as String? ?? ''),
      itemsCount = (json['items_count'] as num?)?.toInt() ?? 0,
      total = (json['total'] as num?)?.toDouble() ?? 0,
      paymentMethod = PaymentMethod.fromJson(json['payment_method'] as String?),
      isPaid = json['is_paid'] as bool? ?? false;

  final String id;

  /// Order number without the `#` (e.g. `ORD-10234`).
  final String code;
  final String customerName;
  final CustomerType customerType;

  /// Saudi national number without the country code (e.g. `501234567`).
  final String phone;

  /// e.g. "حي العليا".
  final String district;

  /// e.g. "الرياض".
  final String city;
  final double latitude;
  final double longitude;

  /// From the courier's position; null for past orders.
  final double? distanceKm;
  final OrderStatus status;

  /// When the order was given to the courier (current cards).
  final DateTime assignedAt;

  /// Delivered / last attempt / refused at (past cards).
  final DateTime? closedAt;
  final int itemsCount;

  /// What the customer pays, delivery included.
  final double total;
  final PaymentMethod paymentMethod;

  /// Prepaid, or cash already collected.
  final bool isPaid;

  /// Cash still to collect from the customer ("تحصيل").
  bool get needsCollection =>
      paymentMethod == PaymentMethod.cashOnDelivery && !isPaid;
}
