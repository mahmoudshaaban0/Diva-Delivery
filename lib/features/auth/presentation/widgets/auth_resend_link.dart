import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// "Didn't get the code? Resend code" (Figma "Resend"), shared by the OTP
/// and forgot-password screens. Disabled when [onTap] is null.
class AuthResendLink extends StatelessWidget {
  const AuthResendLink({
    required this.question,
    required this.actionLabel,
    required this.onTap,
    super.key,
  });

  final String question;
  final String actionLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.w,
      children: [
        AppText(
          question,
          style: context.typography.bodyS,
          color: context.colors.textSubTitle,
        ),
        GestureDetector(
          onTap: onTap,
          child: AppText(
            actionLabel,
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
