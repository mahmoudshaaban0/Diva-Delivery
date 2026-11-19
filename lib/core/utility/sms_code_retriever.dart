import 'package:limitless_code_template/core/constants/app_regex.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

/// Android SMS autofill for `Pinput`, using the SMS User Consent API through
/// `smart_auth`: the user taps "Allow" on a system prompt and the code is
/// filled in. Unlike the SMS Retriever API, it needs no app hash in the SMS.
///
/// iOS doesn't need this: `Pinput`'s `oneTimeCode` autofill hint shows the
/// code above the keyboard.
class SmsCodeRetriever implements SmsRetriever {
  const SmsCodeRetriever();

  @override
  Future<String?> getSmsCode() async {
    final result = await SmartAuth.instance.getSmsWithUserConsentApi(
      matcher: AppRegex.otpCode.pattern,
    );
    return result.data?.code;
  }

  @override
  Future<void> dispose() async {
    await SmartAuth.instance.removeUserConsentApiListener();
  }

  @override
  bool get listenForMultipleSms => false;
}
