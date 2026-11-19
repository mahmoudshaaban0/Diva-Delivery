import 'package:limitless_code_template/core/cubit/base_state.dart';

class OtpState extends BaseState<OtpState> {
  const OtpState({
    super.status,
    super.errorMessage,
    this.secondsLeft = 0,
    this.isResending = false,
    this.isCodeInvalid = false,
    this.attemptsLeft,
  });

  /// Resend countdown; resending is allowed at 0.
  final int secondsLeft;
  final bool isResending;

  /// The last submitted code was rejected (Figma "رمز التحقق – خطأ").
  final bool isCodeInvalid;

  /// Remaining attempts reported by the server, if any.
  final int? attemptsLeft;

  /// Allowed once the countdown ends, or straight after a rejected code
  /// (Figma shows the resend link on the error state).
  bool get canResend => !isResending && (secondsLeft == 0 || isCodeInvalid);

  @override
  OtpState copyWith({
    AppStatus? status,
    String? errorMessage,
    int? secondsLeft,
    bool? isResending,
    bool? isCodeInvalid,
    int? attemptsLeft,
  }) {
    return OtpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      secondsLeft: secondsLeft ?? this.secondsLeft,
      isResending: isResending ?? this.isResending,
      isCodeInvalid: isCodeInvalid ?? this.isCodeInvalid,
      attemptsLeft: attemptsLeft ?? this.attemptsLeft,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    secondsLeft,
    isResending,
    isCodeInvalid,
    attemptsLeft,
  ];
}
