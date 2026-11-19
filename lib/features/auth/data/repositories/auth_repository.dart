import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/core/utility/logger.dart';
import 'package:limitless_code_template/features/auth/data/datasources/auth_data_source.dart';
import 'package:limitless_code_template/features/auth/data/models/auth_response_model.dart';
import 'package:limitless_code_template/features/auth/data/models/otp_sent_model.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this.authDataSource);
  final AuthDataSource authDataSource;

  /// Never throws: returns [Success] with the data or [Error] with the
  /// exception (a [ServerException] subclass).
  Future<Result<OtpSentModel>> sendOtp({required String phone}) async {
    try {
      final data = await authDataSource.sendOtp(phone: phone);
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

  /// Never throws. A wrong code comes back as `Error(InvalidOtpException)`.
  Future<Result<AuthResponseModel>> verifyOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final data = await authDataSource.verifyOtp(phone: phone, code: code);
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

  /// Never throws: returns [Success] with the session or [Error].
  Future<Result<AuthResponseModel>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final data = await authDataSource.loginWithEmail(
        email: email,
        password: password,
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
