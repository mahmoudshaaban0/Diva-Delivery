import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// "Secure, encrypted connection" line under the login card (Figma "Trust").
class LoginTrustNote extends StatelessWidget {
  const LoginTrustNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4.w,
      children: [
        AppSvgIcon(
          Assets.vectorsIcShield16,
          size: 16,
          color: context.colors.textCaption,
        ),
        Flexible(
          child: AppText(
            context.localizations.secureConnection,
            style: context.typography.bodyXS,
            color: context.colors.textCaption,
          ),
        ),
      ],
    );
  }
}
