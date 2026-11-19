import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_circle_icon_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_logo.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Logo + support button row and the welcome heading (Figma "Hero").
class LoginHeader extends StatelessWidget {
  const LoginHeader({required this.onSupport, super.key});

  final VoidCallback onSupport;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppLogo.small(color: context.colors.brandPrimary),
            AppCircleIconButton(
              tooltip: context.localizations.contactSupport,
              onPressed: onSupport,
              icon: const AppSvgIcon(
                Assets.vectorsIcCustomerSupport22,
                size: 22,
              ),
            ),
          ],
        ),
        gapH20,
        AppText(
          context.localizations.loginWelcome,
          style: context.typography.titleM,
        ),
        gapH8,
        AppText(
          context.localizations.loginSubtitle,
          color: context.colors.textBody,
        ),
      ],
    );
  }
}
