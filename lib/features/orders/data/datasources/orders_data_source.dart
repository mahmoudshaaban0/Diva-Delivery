import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/features/orders/data/models/order_details_model.dart';
import 'package:limitless_code_template/features/orders/data/models/orders_response_model.dart';

/// Courier orders API. Endpoints come from `env/<flavor>.json`.
///
/// NOTE: payloads are assumptions until the API contract is shared. Assumed
/// envelope: `{"success": bool, "message": String?, "data": {...}}`.
/// `DioConsumer` doesn't throw for 4xx, so failures are read from `success`.
class OrdersDataSource {
  OrdersDataSource(this.apiConsumer);
  final ApiConsumer apiConsumer;

  /// `?scope=current|previous`.
  Future<OrdersResponseModel> getOrders(OrdersScope scope) async {
    final response = await apiConsumer.get(
      Env.ordersEndpoint,
      queryParameters: {'scope': scope.name},
    );
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
    return OrdersResponseModel.fromJson(
      json['data'] as Map<String, dynamic>? ?? {},
    );
  }

  /// `ORDER_DETAILS_ENDPOINT` with its `{id}` placeholder filled in.
  Future<OrderDetailsModel> getOrderDetails(String id) async {
    final response = await apiConsumer.get(
      Env.orderDetailsEndpoint.replaceAll('{id}', id),
    );
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
    return OrderDetailsModel.fromJson(
      json['data'] as Map<String, dynamic>? ?? {},
    );
  }
}
