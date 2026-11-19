import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
    super.key,
  });

  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.s24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppIcon(
              Icons.error_outline,
              size: AppIconSize.xl,
              tone: AppIconTone.error,
            ),
            gapH16,
            AppText(
              message,
              style: context.typography.bodyS,
              color: context.colors.textCaption,
              textAlign: TextAlign.center,
            ),
            gapH16,
          ],
        ),
      ),
    );
  }
}
