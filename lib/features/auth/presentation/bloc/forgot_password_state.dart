import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/features/auth/data/models/reset_link_sent_model.dart';

class ForgotPasswordState extends BaseState<ForgotPasswordState> {
  const ForgotPasswordState({
    super.status,
    super.errorMessage,
    this.isLinkSent = false,
    this.email = '',
    this.validForMinutes = ResetLinkSentModel.defaultValidForMinutes,
    this.secondsLeft = 0,
    this.isResending = false,
    this.isOffline = false,
  });

  /// True once the first link was sent (Figma "تم إرسال الرابط").
  final bool isLinkSent;

  /// Address the link was sent to.
  final String email;
  final int validForMinutes;

  /// Resend countdown; resending is allowed at 0.
  final int secondsLeft;
  final bool isResending;

  /// The last failure was a missing connection (shown as a toast).
  final bool isOffline;

  bool get canResend => secondsLeft == 0 && !isResending;

  @override
  ForgotPasswordState copyWith({
    AppStatus? status,
    String? errorMessage,
    bool? isLinkSent,
    String? email,
    int? validForMinutes,
    int? secondsLeft,
    bool? isResending,
    bool? isOffline,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLinkSent: isLinkSent ?? this.isLinkSent,
      email: email ?? this.email,
      validForMinutes: validForMinutes ?? this.validForMinutes,
      secondsLeft: secondsLeft ?? this.secondsLeft,
      isResending: isResending ?? this.isResending,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    isLinkSent,
    email,
    validForMinutes,
    secondsLeft,
    isResending,
    isOffline,
  ];
}
