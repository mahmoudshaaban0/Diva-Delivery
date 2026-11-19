import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Primary action + terms notice pinned to the bottom (Figma "Footer").
class LoginFooter extends StatelessWidget {
  const LoginFooter({
    required this.label,
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        children: [
          AppFilledButton(
            isLoading: isLoading,
            onPressed: onPressed,
            child: AppText(
              label,
              style: context.typography.subtitleM.copyWith(
                fontWeight: FontWeight.w700,
              ),
              color: context.colors.buttonPrimary.label,
            ),
          ),
          gapH12,
          AppText(
            context.localizations.termsNotice,
            style: context.typography.bodyXS,
            color: context.colors.textCaption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
