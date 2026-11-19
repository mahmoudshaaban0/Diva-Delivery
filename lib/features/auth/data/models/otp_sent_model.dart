/// Response of "send OTP".
///
/// Assumed payload: `{"data": {"resend_after": 45}}`.
class OtpSentModel {
  const OtpSentModel({this.resendAfterSeconds = defaultResendAfter});

  OtpSentModel.fromJson(Map<String, dynamic> json)
    : resendAfterSeconds =
          (json['resend_after'] as num?)?.toInt() ?? defaultResendAfter;

  /// Figma shows a 00:45 countdown.
  static const int defaultResendAfter = 45;

  final int resendAfterSeconds;

  Map<String, dynamic> toJson() => {'resend_after': resendAfterSeconds};
}
