import 'package:limitless_code_template/features/notifications/data/models/notification_model.dart';

/// The notifications list, newest first.
///
/// NOTE: assumed payload until the API contract is shared:
/// `{"notifications": [<NotificationModel>, …]}`. No paging yet.
class NotificationsResponseModel {
  const NotificationsResponseModel({required this.notifications});

  NotificationsResponseModel.fromJson(Map<String, dynamic> json)
    : notifications = [
        for (final item
            in json['notifications'] as List<dynamic>? ?? <dynamic>[])
          NotificationModel.fromJson(item as Map<String, dynamic>),
      ];

  final List<NotificationModel> notifications;
}
