/// The courier's profile (Figma Flow 07 "الملف الشخصي" / "المعلومات
/// الشخصية").
///
/// NOTE: assumed payload until the API contract is shared:
/// ```json
/// {
///   "name": "خالد العتيبي", "code": "DRV-0142",
///   "phone": "551234567", "email": "khalid@expertpartners.sa",
///   "photo_url": null, "on_duty": true,
///   "warehouse": "مستودع الرياض الرئيسي", "supervisor": "خالد الشهري",
///   "vehicle": "هايلكس · ر ج ب 4821", "joined_at": "2025-03-01",
///   "open_orders": 3
/// }
/// ```
class ProfileResponseModel {
  const ProfileResponseModel({
    required this.name,
    required this.code,
    required this.phone,
    required this.email,
    required this.warehouse,
    required this.supervisor,
    required this.vehicle,
    required this.joinedAt,
    this.photoUrl,
    this.isOnDuty = false,
    this.openOrders = 0,
  });

  ProfileResponseModel.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String? ?? '',
      code = json['code'] as String? ?? '',
      phone = json['phone'] as String? ?? '',
      email = json['email'] as String? ?? '',
      photoUrl = json['photo_url'] as String?,
      isOnDuty = json['on_duty'] as bool? ?? false,
      warehouse = json['warehouse'] as String? ?? '',
      supervisor = json['supervisor'] as String? ?? '',
      vehicle = json['vehicle'] as String? ?? '',
      joinedAt = DateTime.tryParse(json['joined_at'] as String? ?? ''),
      openOrders = (json['open_orders'] as num?)?.toInt() ?? 0;

  final String name;

  /// Courier number without the `#` (e.g. `DRV-0142`).
  final String code;

  /// Saudi national number without the country code (e.g. `551234567`).
  final String phone;
  final String email;

  /// Uploaded photo (a URL, or a local file path from the offline fake);
  /// null shows the initials.
  final String? photoUrl;

  /// "في الخدمة": the courier's day is running.
  final bool isOnDuty;
  final String warehouse;
  final String supervisor;
  final String vehicle;
  final DateTime? joinedAt;

  /// Orders still being delivered (or cash not handed in). Logging out with
  /// any shows the "لديك طلبات مفتوحة" warning.
  final int openOrders;

  bool get hasOpenOrders => openOrders > 0;

  /// [photoUrl] can't be cleared through a `copyWith` with nullable
  /// arguments, so the photo has its own copy method.
  ProfileResponseModel withPhoto(String? photoUrl) => ProfileResponseModel(
    name: name,
    code: code,
    phone: phone,
    email: email,
    photoUrl: photoUrl,
    isOnDuty: isOnDuty,
    warehouse: warehouse,
    supervisor: supervisor,
    vehicle: vehicle,
    joinedAt: joinedAt,
    openOrders: openOrders,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code,
    'phone': phone,
    'email': email,
    'photo_url': photoUrl,
    'on_duty': isOnDuty,
    'warehouse': warehouse,
    'supervisor': supervisor,
    'vehicle': vehicle,
    'joined_at': joinedAt?.toIso8601String(),
    'open_orders': openOrders,
  };
}
