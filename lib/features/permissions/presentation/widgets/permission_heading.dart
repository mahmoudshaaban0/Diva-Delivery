import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Centered title + description of a permission screen (Figma "Heading").
class PermissionHeading extends StatelessWidget {
  const PermissionHeading({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(
          title,
          style: context.typography.titleM,
          textAlign: TextAlign.center,
        ),
        gapH8,
        AppText(
          subtitle,
          color: context.colors.textSubTitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
