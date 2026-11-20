import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/features/home/data/models/home_response_model.dart';
import 'package:limitless_code_template/features/home/data/models/start_day_response_model.dart';

/// Courier home API. Endpoints come from `env/<flavor>.json`.
///
/// NOTE: payloads are assumptions until the API contract is shared. Assumed
/// envelope: `{"success": bool, "message": String?, "data": {...}}`.
/// `DioConsumer` doesn't throw for 4xx, so failures are read from `success`.
class HomeDataSource {
  HomeDataSource(this.apiConsumer);
  final ApiConsumer apiConsumer;

  Future<HomeResponseModel> getHome() async {
    final response = await apiConsumer.get(Env.homeEndpoint);
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
    return HomeResponseModel.fromJson(
      json['data'] as Map<String, dynamic>? ?? {},
    );
  }

  /// The server checks the position against the warehouse geofence. Outside
  /// it, the response is `success: false` with `data.distance_km`.
  Future<StartDayResponseModel> startDay({
    required double latitude,
    required double longitude,
  }) async {
    final response = await apiConsumer.post(
      Env.startDayEndpoint,
      body: {'latitude': latitude, 'longitude': longitude},
    );
    final json = response as Map<String, dynamic>? ?? {};
    final data = json['data'] as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      final distance = data['distance_km'] as num?;
      if (distance != null) {
        throw OutOfWarehouseRangeException(
          distanceKm: distance.toDouble(),
          message: json['message'] as String?,
        );
      }
      throw BadRequestException(json['message'] as String?);
    }
    return StartDayResponseModel.fromJson(data);
  }
}
