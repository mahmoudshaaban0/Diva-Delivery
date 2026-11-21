/// Filter chips on "الإشعارات": الطلبات · التحصيل · التنبيهات.
enum NotificationCategory { orders, collection, alerts }

/// What happened; picks the icon, the tone and the filter (Figma
/// `Courier/Notification Item`: Brand طلبات · Yellow جدولة · Green تحصيل ·
/// Red تنبيه).
enum NotificationType {
  /// "طلب جديد مُسند إليك".
  newOrder,

  /// "أُعيدت جدولة طلب".
  rescheduled,

  /// "تغيّر عنوان التسليم".
  addressChanged,

  /// "تم إغلاق طلب" (delivered and collected).
  orderClosed,

  /// "تم إنهاء يومك".
  dayEnded,

  /// "تذكير بتسليم المبالغ".
  cashReminder;

  NotificationCategory get category => switch (this) {
    newOrder || rescheduled || addressChanged => NotificationCategory.orders,
    orderClosed || dayEnded => NotificationCategory.collection,
    cashReminder => NotificationCategory.alerts,
  };

  static NotificationType fromJson(String? value) => switch (value) {
    'rescheduled' => rescheduled,
    'address_changed' => addressChanged,
    'order_closed' => orderClosed,
    'day_ended' => dayEnded,
    'cash_reminder' => cashReminder,
    _ => newOrder,
  };
}

/// One notification (Figma `Courier/Notification Item` and `Courier/Push
/// Banner`). Title and text come translated from the server.
///
/// NOTE: assumed payload until the API contract is shared:
/// ```json
/// {
///   "id": "n1", "type": "new_order",
///   "title": "طلب جديد مُسند إليك",
///   "body": "#ORD-10241 · سارة القحطاني · حي الملقا",
///   "created_at": "2026-11-15T09:36:00", "is_read": false,
///   "order_id": "10241"
/// }
/// ```
class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
    this.orderId,
  });

  NotificationModel.fromJson(Map<String, dynamic> json)
    : id = '${json['id'] ?? ''}',
      type = NotificationType.fromJson(json['type'] as String?),
      title = json['title'] as String? ?? '',
      body = json['body'] as String? ?? '',
      createdAt =
          DateTime.tryParse(json['created_at'] as String? ?? '') ??
          DateTime.now(),
      isRead = json['is_read'] as bool? ?? false,
      orderId = json['order_id'] as String?;

  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;

  /// Tapping opens this order's details when set.
  final String? orderId;

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
    id: id,
    type: type,
    title: title,
    body: body,
    createdAt: createdAt,
    isRead: isRead ?? this.isRead,
    orderId: orderId,
  );
}
