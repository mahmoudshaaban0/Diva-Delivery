import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/features/profile/data/models/profile_response_model.dart';

/// Courier profile API. Endpoints come from `env/<flavor>.json`.
///
/// NOTE: payloads are assumptions until the API contract is shared. Assumed
/// envelope: `{"success": bool, "message": String?, "data": {...}}`.
/// `DioConsumer` doesn't throw for 4xx, so failures are read from `success`.
class ProfileDataSource {
  ProfileDataSource(this.apiConsumer);
  final ApiConsumer apiConsumer;

  Future<ProfileResponseModel> getProfile() async {
    final response = await apiConsumer.get(Env.profileEndpoint);
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
    return ProfileResponseModel.fromJson(
      json['data'] as Map<String, dynamic>? ?? {},
    );
  }

  /// Uploads the photo at [imagePath] (multipart field `image`) and returns
  /// its new URL (`data.photo_url`).
  Future<String> updatePhoto(String imagePath) async {
    final response = await apiConsumer.multipart(
      Env.profilePhotoEndpoint,
      imgPath: imagePath,
    );
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final url = data['photo_url'] as String?;
    if (url == null) {
      throw const FormatException('Missing photo_url in the response.');
    }
    return url;
  }

  Future<void> deletePhoto() async {
    final response = await apiConsumer.delete(Env.profilePhotoEndpoint);
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
  }

  /// Ends the session on the server (stops location tracking and new
  /// orders).
  Future<void> logout() async {
    final response = await apiConsumer.post(Env.logoutEndpoint);
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
  }
}
