import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/core/utility/logger.dart';
import 'package:limitless_code_template/features/home/data/datasources/home_data_source.dart';
import 'package:limitless_code_template/features/home/data/models/home_response_model.dart';
import 'package:limitless_code_template/features/home/data/models/start_day_response_model.dart';

@lazySingleton
class HomeRepository {
  HomeRepository(this.homeDataSource);
  final HomeDataSource homeDataSource;

  /// Never throws: returns [Success] with the data or [Error] with the
  /// exception (a [ServerException] subclass).
  Future<Result<HomeResponseModel>> getHome() async {
    try {
      final data = await homeDataSource.getHome();
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

  /// Never throws. Outside the warehouse zone comes back as
  /// `Error(OutOfWarehouseRangeException)`.
  Future<Result<StartDayResponseModel>> startDay({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final data = await homeDataSource.startDay(
        latitude: latitude,
        longitude: longitude,
      );
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
}
