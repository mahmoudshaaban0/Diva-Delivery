import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/network_info.dart';
import 'package:limitless_code_template/features/notifications/data/datasources/notifications_data_source.dart';
import 'package:limitless_code_template/features/notifications/data/models/notification_model.dart';
import 'package:limitless_code_template/features/notifications/data/models/notifications_response_model.dart';

/// Offline stand-in used while there is no backend (`BASE_URL` empty), with
/// the Figma sample notifications. See `NotificationsModule`.
///
/// - Every call checks the real connection first (offline → error state).
/// - [_incomingDelay] after the app opens, one "طلب جديد مُسند إليك"
///   arrives, to show the in-app banner (Figma "إشعار داخل التطبيق").
///   Set [_sendIncoming] to false to turn it off.
class FakeNotificationsDataSource implements NotificationsDataSource {
  FakeNotificationsDataSource(this.networkInfo);

  final NetworkInfo networkInfo;

  static const _latency = Duration(milliseconds: 700);
  static const _sendIncoming = true;
  static const _incomingDelay = Duration(seconds: 12);

  @override
  Never get apiConsumer =>
      throw UnsupportedError('FakeNotificationsDataSource has no ApiConsumer');

  @override
  Future<NotificationsResponseModel> getNotifications() async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
    await Future<void>.delayed(_latency);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    return NotificationsResponseModel(
      notifications: [
        NotificationModel(
          id: 'n1',
          type: NotificationType.newOrder,
          title: 'طلب جديد مُسند إليك',
          body: '#ORD-10241 · سارة القحطاني · حي الملقا',
          createdAt: now.subtract(const Duration(minutes: 5)),
          orderId: '10241',
        ),
        NotificationModel(
          id: 'n2',
          type: NotificationType.rescheduled,
          title: 'أُعيدت جدولة طلب',
          body: '#ORD-10198 · غدًا 10:00 ص بعد مراجعة المشرف',
          createdAt: now.subtract(const Duration(minutes: 32)),
          orderId: '10198',
        ),
        NotificationModel(
          id: 'n3',
          type: NotificationType.orderClosed,
          title: 'تم إغلاق طلب',
          body: '#ORD-10234 · تم التسليم والتحصيل',
          createdAt: today.add(const Duration(hours: 12, minutes: 10)),
          isRead: true,
          orderId: '10234',
        ),
        NotificationModel(
          id: 'n4',
          type: NotificationType.cashReminder,
          title: 'تذكير بتسليم المبالغ',
          body: 'سلّم المبالغ المحصّلة للمستودع قبل 6:00 م',
          createdAt: today.add(const Duration(hours: 11)),
          isRead: true,
        ),
        NotificationModel(
          id: 'n5',
          type: NotificationType.addressChanged,
          title: 'تغيّر عنوان التسليم',
          body: '#ORD-10187 · حي النرجس · راجع الموقع قبل التوجه',
          createdAt: yesterday.add(const Duration(hours: 16)),
          isRead: true,
        ),
        NotificationModel(
          id: 'n6',
          type: NotificationType.dayEnded,
          title: 'تم إنهاء يومك',
          body: '18 طلبًا · بدون فروقات في التحصيل',
          createdAt: yesterday.add(const Duration(hours: 19)),
          isRead: true,
        ),
      ],
    );
  }

  @override
  Future<void> markRead(String id) async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
  }

  @override
  Future<void> markAllRead() async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
    await Future<void>.delayed(_latency);
  }

  @override
  Stream<NotificationModel> watchIncoming() async* {
    if (!_sendIncoming) return;
    await Future<void>.delayed(_incomingDelay);
    yield NotificationModel(
      id: 'n-incoming',
      type: NotificationType.newOrder,
      title: 'طلب جديد مُسند إليك',
      body: 'سارة القحطاني · حي الملقا · 2.4 كم',
      createdAt: DateTime.now(),
      orderId: '10247',
    );
  }
}
