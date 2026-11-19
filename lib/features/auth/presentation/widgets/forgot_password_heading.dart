import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Badge, title and description of the forgot-password screen. Switches to
/// the green "check your email" look once [isLinkSent]
/// (Figma "نسيت كلمة المرور" → "تم إرسال الرابط").
class ForgotPasswordHeading extends StatelessWidget {
  const ForgotPasswordHeading({
    required this.isLinkSent,
    required this.email,
    required this.validForMinutes,
    super.key,
  });

  final bool isLinkSent;
  final String email;
  final int validForMinutes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppIconBadge(
          assetPath: isLinkSent
              ? Assets.vectorsIcMail28
              : Assets.vectorsIcLockPassword28,
          tone: isLinkSent ? AppIconBadgeTone.success : AppIconBadgeTone.brand,
        ),
        gapH24,
        AppText(
          isLinkSent
              ? context.localizations.checkYourEmail
              : context.localizations.forgotPassword,
          style: context.typography.titleM,
          textAlign: TextAlign.center,
        ),
        gapH8,
        AppText(
          isLinkSent
              ? context.localizations.resetLinkSentTo(email, validForMinutes)
              : context.localizations.forgotPasswordSubtitle,
          color: context.colors.textSubTitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
