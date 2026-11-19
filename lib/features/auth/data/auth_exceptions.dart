import 'package:limitless_code_template/core/error/exceptions.dart';

/// The OTP was wrong or expired. [attemptsLeft] is null when the server
/// doesn't say.
class InvalidOtpException extends BadRequestException {
  const InvalidOtpException({this.attemptsLeft, String? message})
    : super(message ?? 'Invalid verification code.');

  final int? attemptsLeft;

  @override
  List<Object?> get props => [...super.props, attemptsLeft];
}
