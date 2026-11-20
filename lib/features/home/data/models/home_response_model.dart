import 'package:limitless_code_template/features/home/data/models/announcement_model.dart';
import 'package:limitless_code_template/features/home/data/models/warehouse_model.dart';

/// Courier home summary.
///
/// NOTE: keys are assumptions until the API contract is shared. Assumed
/// payload (inside the `data` envelope):
/// ```json
/// {
///   "courier_name": "خالد العتيبي", "area": "الرياض · حي عرقة",
///   "total_collected": 8450, "total_orders": 126,
///   "cancelled_orders": 4, "completed_orders": 104, "pending_orders": 18,
///   "delivered_today": 0, "assigned_today": 18,
///   "day_started_at": null,
///   "warehouse": {...}, "announcements": [...]
/// }
/// ```
/// `pending_orders` is "new" before the day starts and "with the captain"
/// after it.
class HomeResponseModel {
  const HomeResponseModel({
    required this.courierName,
    required this.area,
    required this.totalCollected,
    required this.totalOrders,
    required this.cancelledOrders,
    required this.completedOrders,
    required this.pendingOrders,
    required this.deliveredToday,
    required this.assignedToday,
    required this.warehouse,
    this.dayStartedAt,
    this.announcements = const [],
  });

  HomeResponseModel.fromJson(Map<String, dynamic> json)
    : courierName = json['courier_name'] as String? ?? '',
      area = json['area'] as String? ?? '',
      totalCollected = json['total_collected'] as num? ?? 0,
      totalOrders = (json['total_orders'] as num?)?.toInt() ?? 0,
      cancelledOrders = (json['cancelled_orders'] as num?)?.toInt() ?? 0,
      completedOrders = (json['completed_orders'] as num?)?.toInt() ?? 0,
      pendingOrders = (json['pending_orders'] as num?)?.toInt() ?? 0,
      deliveredToday = (json['delivered_today'] as num?)?.toInt() ?? 0,
      assignedToday = (json['assigned_today'] as num?)?.toInt() ?? 0,
      dayStartedAt = DateTime.tryParse(json['day_started_at'] as String? ?? '')
          ?.toLocal(),
      warehouse = WarehouseModel.fromJson(
        json['warehouse'] as Map<String, dynamic>? ?? {},
      ),
      announcements = [
        for (final item in json['announcements'] as List<dynamic>? ?? [])
          AnnouncementModel.fromJson(item as Map<String, dynamic>),
      ];

  final String courierName;
  final String area;
  final num totalCollected;
  final int totalOrders;
  final int cancelledOrders;
  final int completedOrders;
  final int pendingOrders;
  final int deliveredToday;
  final int assignedToday;

  /// Null while the day hasn't started.
  final DateTime? dayStartedAt;
  final WarehouseModel warehouse;
  final List<AnnouncementModel> announcements;

  bool get isDayStarted => dayStartedAt != null;

  Map<String, dynamic> toJson() => {
    'courier_name': courierName,
    'area': area,
    'total_collected': totalCollected,
    'total_orders': totalOrders,
    'cancelled_orders': cancelledOrders,
    'completed_orders': completedOrders,
    'pending_orders': pendingOrders,
    'delivered_today': deliveredToday,
    'assigned_today': assignedToday,
    'day_started_at': dayStartedAt?.toUtc().toIso8601String(),
    'warehouse': warehouse.toJson(),
    'announcements': [for (final a in announcements) a.toJson()],
  };
}
