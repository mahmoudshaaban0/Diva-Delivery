import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/core/utility/logger.dart';
import 'package:limitless_code_template/features/notifications/data/datasources/notifications_data_source.dart';
import 'package:limitless_code_template/features/notifications/data/models/notification_model.dart';
import 'package:limitless_code_template/features/notifications/data/models/notifications_response_model.dart';

@lazySingleton
class NotificationsRepository {
  NotificationsRepository(this.notificationsDataSource);
  final NotificationsDataSource notificationsDataSource;

  /// Never throws: returns [Success] with the data or [Error] with the
  /// exception (a [ServerException] subclass).
  Future<Result<NotificationsResponseModel>> getNotifications() async {
    try {
      final data = await notificationsDataSource.getNotifications();
      return Success(data);
    } on ServerException catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return Error(e);
    } on FormatException catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return const Error(
        BadRequestException('Invalid data received from server.'),
      );
    } on Exception catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return Error(ServerException(e.toString()));
    }
  }

  /// Never throws.
  Future<Result<void>> markRead(String id) async {
    try {
      await notificationsDataSource.markRead(id);
      return const Success(null);
    } on ServerException catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return Error(e);
    } on FormatException catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return const Error(
        BadRequestException('Invalid data received from server.'),
      );
    } on Exception catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return Error(ServerException(e.toString()));
    }
  }

  /// Never throws.
  Future<Result<void>> markAllRead() async {
    try {
      await notificationsDataSource.markAllRead();
      return const Success(null);
    } on ServerException catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return Error(e);
    } on FormatException catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return const Error(
        BadRequestException('Invalid data received from server.'),
      );
    } on Exception catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return Error(ServerException(e.toString()));
    }
  }

  /// Notifications arriving while the app is open.
  Stream<NotificationModel> watchIncoming() =>
      notificationsDataSource.watchIncoming();
}
