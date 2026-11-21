import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/core/utility/logger.dart';
import 'package:limitless_code_template/features/orders/data/datasources/orders_data_source.dart';
import 'package:limitless_code_template/features/orders/data/models/order_details_model.dart';
import 'package:limitless_code_template/features/orders/data/models/orders_response_model.dart';

@lazySingleton
class OrdersRepository {
  OrdersRepository(this.ordersDataSource);
  final OrdersDataSource ordersDataSource;

  /// Never throws: returns [Success] with the data or [Error] with the
  /// exception (a [ServerException] subclass).
  Future<Result<OrdersResponseModel>> getOrders(OrdersScope scope) async {
    try {
      final data = await ordersDataSource.getOrders(scope);
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
  Future<Result<OrderDetailsModel>> getOrderDetails(String id) async {
    try {
      final data = await ordersDataSource.getOrderDetails(id);
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
