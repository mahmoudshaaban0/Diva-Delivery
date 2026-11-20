/// Result of a successful "start day".
///
/// Assumed payload:
/// `{"started_at": "2026-11-15T05:42:00Z", "orders_count": 18}`.
class StartDayResponseModel {
  const StartDayResponseModel({
    required this.startedAt,
    required this.ordersCount,
  });

  StartDayResponseModel.fromJson(Map<String, dynamic> json)
    : startedAt =
          DateTime.tryParse(json['started_at'] as String? ?? '')?.toLocal() ??
          DateTime.now(),
      ordersCount = (json['orders_count'] as num?)?.toInt() ?? 0;

  final DateTime startedAt;

  /// Orders handed to the courier, now "with the captain".
  final int ordersCount;

  Map<String, dynamic> toJson() => {
    'started_at': startedAt.toUtc().toIso8601String(),
    'orders_count': ordersCount,
  };
}
