import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// "Resend in 00:45" pill (Figma "Timer").
class AuthResendTimer extends StatelessWidget {
  const AuthResendTimer({required this.secondsLeft, super.key});

  final int secondsLeft;

  @override
  Widget build(BuildContext context) {
    final minutes = (secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsLeft % 60).toString().padLeft(2, '0');

    return Container(
      padding: AppInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: context.colors.brandPrimaryTint,
        borderRadius: AppRadius.rfull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.w,
        children: [
          AppSvgIcon(
            Assets.vectorsIcClock16,
            size: 16,
            color: context.colors.textSubTitle,
          ),
          AppText(
            context.localizations.resendIn,
            style: context.typography.bodyS,
            color: context.colors.textSubTitle,
          ),
          Text(
            '$minutes:$seconds',
            textDirection: TextDirection.ltr,
            style: context.typography.subtitleS.copyWith(
              color: context.colors.textTitle,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
