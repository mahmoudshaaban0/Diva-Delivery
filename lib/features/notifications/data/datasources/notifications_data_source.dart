import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/features/notifications/data/models/notification_model.dart';
import 'package:limitless_code_template/features/notifications/data/models/notifications_response_model.dart';

/// Courier notifications API. Endpoints come from `env/<flavor>.json`.
///
/// NOTE: payloads are assumptions until the API contract is shared. Assumed
/// envelope: `{"success": bool, "message": String?, "data": {...}}`.
class NotificationsDataSource {
  NotificationsDataSource(this.apiConsumer);
  final ApiConsumer apiConsumer;

  Future<NotificationsResponseModel> getNotifications() async {
    final response = await apiConsumer.get(Env.notificationsEndpoint);
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
    return NotificationsResponseModel.fromJson(
      json['data'] as Map<String, dynamic>? ?? {},
    );
  }

  Future<void> markRead(String id) async {
    final response = await apiConsumer.post(
      Env.notificationReadEndpoint.replaceAll('{id}', id),
    );
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
  }

  Future<void> markAllRead() async {
    final response = await apiConsumer.post(Env.notificationsReadAllEndpoint);
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
  }

  /// Notifications that arrive while the app is open (shown as the in-app
  /// banner).
  ///
  /// NOTE: no push service is set up yet; connect FCM (or the backend's
  /// socket) here once it is. Until then nothing arrives.
  Stream<NotificationModel> watchIncoming() => const Stream.empty();
}
