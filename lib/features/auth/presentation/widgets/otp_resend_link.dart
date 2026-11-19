import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// "Didn't get the code? Resend code" (Figma "Resend"). Disabled when
/// [onTap] is null.
class OtpResendLink extends StatelessWidget {
  const OtpResendLink({required this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        AppText(
          context.localizations.otpNotReceived,
          style: context.typography.bodyS,
          color: context.colors.textSubTitle,
        ),
        GestureDetector(
          onTap: onTap,
          child: AppText(
            context.localizations.otpResend,
            style: context.typography.subtitleS,
            color: onTap == null
                ? context.colors.textCaption
                : context.colors.brandPrimary,
          ),
        ),
      ],
    );
  }
}
