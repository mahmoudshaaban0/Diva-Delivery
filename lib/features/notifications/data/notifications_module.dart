import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/core/networking/network_info.dart';
import 'package:limitless_code_template/features/notifications/data/datasources/fake_notifications_data_source.dart';
import 'package:limitless_code_template/features/notifications/data/datasources/notifications_data_source.dart';

@module
abstract class NotificationsModule {
  /// Uses the offline [FakeNotificationsDataSource] until a `BASE_URL` is
  /// configured.
  @lazySingleton
  NotificationsDataSource notificationsDataSource(
    ApiConsumer apiConsumer,
    NetworkInfo networkInfo,
  ) => Env.baseUrl.isEmpty
      ? FakeNotificationsDataSource(networkInfo)
      : NotificationsDataSource(apiConsumer);
}
