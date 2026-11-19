import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/features/auth/data/auth_exceptions.dart';
import 'package:limitless_code_template/features/auth/data/datasources/auth_data_source.dart';
import 'package:limitless_code_template/features/auth/data/models/auth_response_model.dart';
import 'package:limitless_code_template/features/auth/data/models/otp_sent_model.dart';

/// Offline stand-in used while there is no backend (`BASE_URL` empty), so the
/// login → OTP flow can be clicked through. See `AuthModule`.
///
/// - Any valid phone number gets a code. The correct code is [validCode].
/// - A wrong code returns [InvalidOtpException] with a decreasing
///   `attemptsLeft`.
/// - Any email + non-empty password signs in.
class FakeAuthDataSource implements AuthDataSource {
  static const validCode = '1234';
  static const _maxAttempts = 3;
  static const _latency = Duration(milliseconds: 800);

  int _attemptsLeft = _maxAttempts;

  @override
  Never get apiConsumer =>
      throw UnsupportedError('FakeAuthDataSource has no ApiConsumer');

  @override
  Future<OtpSentModel> sendOtp({required String phone}) async {
    await Future<void>.delayed(_latency);
    _attemptsLeft = _maxAttempts;
    return const OtpSentModel();
  }

  @override
  Future<AuthResponseModel> verifyOtp({
    required String phone,
    required String code,
  }) async {
    await Future<void>.delayed(_latency);
    if (code == validCode) {
      return const AuthResponseModel(token: 'fake-token');
    }
    if (_attemptsLeft > 0) _attemptsLeft--;
    throw InvalidOtpException(attemptsLeft: _attemptsLeft);
  }

  @override
  Future<AuthResponseModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_latency);
    if (password.isEmpty) throw const UnauthorizedException();
    return const AuthResponseModel(token: 'fake-token');
  }
}
