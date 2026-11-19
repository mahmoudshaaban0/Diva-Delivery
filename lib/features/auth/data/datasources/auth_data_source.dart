import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/formatters/phone_formatter.dart';
import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/features/auth/data/auth_exceptions.dart';
import 'package:limitless_code_template/features/auth/data/models/auth_response_model.dart';
import 'package:limitless_code_template/features/auth/data/models/otp_sent_model.dart';

/// Courier authentication API. Endpoints come from `env/<flavor>.json`.
///
/// NOTE: payloads are assumptions until the API contract is shared. Assumed
/// envelope for every response:
/// `{"success": bool, "message": String?, "data": {...}}`.
/// `DioConsumer` doesn't throw for 4xx, so failures are read from `success`.
class AuthDataSource {
  AuthDataSource(this.apiConsumer);
  final ApiConsumer apiConsumer;

  /// [phone] is the national number without the country code (5XXXXXXXX).
  Future<OtpSentModel> sendOtp({required String phone}) async {
    final response = await apiConsumer.post(
      Env.sendOtpEndpoint,
      body: {'phone': phone, 'country_code': PhoneFormatter.countryCode},
    );
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
    return OtpSentModel.fromJson(json['data'] as Map<String, dynamic>? ?? {});
  }

  Future<AuthResponseModel> verifyOtp({
    required String phone,
    required String code,
  }) async {
    final response = await apiConsumer.post(
      Env.verifyOtpEndpoint,
      body: {
        'phone': phone,
        'country_code': PhoneFormatter.countryCode,
        'code': code,
      },
    );
    final json = response as Map<String, dynamic>? ?? {};
    final data = json['data'] as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw InvalidOtpException(
        message: json['message'] as String?,
        attemptsLeft: (data['attempts_left'] as num?)?.toInt(),
      );
    }
    return AuthResponseModel.fromJson(data);
  }

  Future<AuthResponseModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await apiConsumer.post(
      Env.loginEndpoint,
      body: {'email': email, 'password': password},
    );
    final json = response as Map<String, dynamic>? ?? {};
    if (json['success'] == false) {
      throw BadRequestException(json['message'] as String?);
    }
    return AuthResponseModel.fromJson(
      json['data'] as Map<String, dynamic>? ?? {},
    );
  }
}
