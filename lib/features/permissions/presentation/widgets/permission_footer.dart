import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Primary action with an optional second button under it (Figma "Footer").
class PermissionFooter extends StatelessWidget {
  const PermissionFooter({
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.secondaryVariant = AppFilledVariant.neutral,
    this.isLoading = false,
    super.key,
  });

  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  /// `neutral` (outlined white, "Later") or `primarySoft` ("Try again").
  final AppFilledVariant secondaryVariant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.typography.subtitleM.copyWith(
      fontWeight: FontWeight.w700,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        children: [
          AppFilledButton(
            isLoading: isLoading,
            onPressed: onPrimary,
            child: AppText(
              primaryLabel,
              style: labelStyle,
              color: context.colors.buttonPrimary.label,
            ),
          ),
          if (secondaryLabel != null) ...[
            gapH12,
            AppFilledButton(
              variant: secondaryVariant,
              onPressed: isLoading ? null : onSecondary,
              child: AppText(
                secondaryLabel!,
                style: labelStyle,
                color: context.colors.textTitle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
