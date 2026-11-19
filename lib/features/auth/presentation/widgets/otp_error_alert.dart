import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_inline_alert.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/otp_state.dart';

/// Error banner for a failed verify/resend. A rejected code shows the
/// "attempts left" message when the server reports a count.
class OtpErrorAlert extends StatelessWidget {
  const OtpErrorAlert({required this.state, super.key});

  final OtpState state;

  @override
  Widget build(BuildContext context) {
    final attempts = state.attemptsLeft;

    final message = !state.isCodeInvalid
        ? state.errorMessage ?? context.localizations.otpInvalid
        : attempts == null
        ? context.localizations.otpInvalid
        : context.localizations.otpInvalidAttempts(attempts);

    return AppInlineAlert(message: message);
  }
}
