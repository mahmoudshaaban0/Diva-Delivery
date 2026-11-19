import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/formatters/phone_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Badge, title and "sent to" line of the OTP screen. Switches to the error
/// look when [isCodeInvalid] (Figma "رمز التحقق – خطأ").
class OtpHeading extends StatelessWidget {
  const OtpHeading({
    required this.phone,
    required this.codeLength,
    required this.isCodeInvalid,
    super.key,
  });

  /// 9-digit national number.
  final String phone;
  final int codeLength;
  final bool isCodeInvalid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppIconBadge(
          assetPath: isCodeInvalid
              ? Assets.vectorsIcLockPassword28
              : Assets.vectorsIcSmartPhone28,
          tone: isCodeInvalid ? AppIconBadgeTone.error : AppIconBadgeTone.brand,
        ),
        gapH24,
        AppText(
          isCodeInvalid
              ? context.localizations.otpHeadingError
              : context.localizations.otpHeading,
          style: context.typography.titleM,
          textAlign: TextAlign.center,
        ),
        gapH8,
        AppText(
          context.localizations.otpSentTo(codeLength),
          color: context.colors.textSubTitle,
          textAlign: TextAlign.center,
        ),
        gapH8,
        Text(
          PhoneFormatter.saudiDisplay(phone),
          textDirection: TextDirection.ltr,
          style: context.typography.subtitleM.copyWith(
            color: context.colors.textTitle,
          ),
        ),
      ],
    );
  }
}
