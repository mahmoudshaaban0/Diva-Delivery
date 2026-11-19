import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.message,
    super.key,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppPadding.s24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(icon, size: AppIconSize.xl, tone: AppIconTone.subtle),
            gapH16,
            AppText(
              message,
              style: context.typography.bodyS,
              color: context.colors.textCaption,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[gapH16],
          ],
        ),
      ),
    );
  }
}
