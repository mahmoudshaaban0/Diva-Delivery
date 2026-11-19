/// Response of "send password reset link".
///
/// Assumed payload: `{"data": {"resend_after": 45, "valid_for_minutes": 30}}`.
class ResetLinkSentModel {
  const ResetLinkSentModel({
    this.resendAfterSeconds = defaultResendAfter,
    this.validForMinutes = defaultValidForMinutes,
  });

  ResetLinkSentModel.fromJson(Map<String, dynamic> json)
    : resendAfterSeconds =
          (json['resend_after'] as num?)?.toInt() ?? defaultResendAfter,
      validForMinutes =
          (json['valid_for_minutes'] as num?)?.toInt() ??
          defaultValidForMinutes;

  /// Figma shows a 00:45 countdown and a 30-minute link.
  static const int defaultResendAfter = 45;
  static const int defaultValidForMinutes = 30;

  final int resendAfterSeconds;
  final int validForMinutes;

  Map<String, dynamic> toJson() => {
    'resend_after': resendAfterSeconds,
    'valid_for_minutes': validForMinutes,
  };
}
