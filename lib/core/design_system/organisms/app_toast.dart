import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_shadows.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Floating pill snackbar (Figma `Courier/Toast`): optional 20-px icon,
/// message, optional action. Show it with `context.showToast(...)`.
class AppToast extends StatelessWidget {
  const AppToast({
    required this.message,
    this.iconAsset,
    this.iconColor,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String message;

  /// A 20-px SVG icon from `Assets`.
  final String? iconAsset;

  /// Defaults to `systemYellow` (the Figma warning icon color).
  final Color? iconColor;
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Bottom margin that keeps the toast just above a screen's standard
  /// footer (12 top padding + 46 button + 8 bottom padding + 16 gap).
  static const double aboveFooterMargin = 82;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        // Figma binds this to Brand/Deep, which turns light in the derived
        // dark palette; the scrim token stays dark in both themes so the
        // white text always reads.
        color: context.colors.surfaceScrim,
        borderRadius: AppRadius.rfull,
        boxShadow: AppShadow.toast,
      ),
      child: Row(
        spacing: 10,
        children: [
          if (iconAsset != null)
            AppSvgIcon(
              iconAsset!,
              size: 20,
              color: iconColor ?? context.colors.systemYellow,
            ),
          Expanded(
            child: AppText(
              message,
              style: context.typography.bodyS,
              color: context.colors.textAlwaysWhite,
            ),
          ),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              behavior: HitTestBehavior.opaque,
              child: AppText(
                actionLabel!,
                style: context.typography.subtitleS,
                color: context.colors.textAlwaysWhite,
              ),
            ),
        ],
      ),
    );
  }
}

extension AppToastContext on BuildContext {
  /// Shows an [AppToast] as a floating snackbar, replacing any visible one.
  /// Tapping the action hides the toast, then calls [onAction].
  ///
  /// Pass [bottomMargin] = [AppToast.aboveFooterMargin] on screens with a
  /// pinned footer button so the toast floats above it, like the design.
  void showToast({
    required String message,
    String? iconAsset,
    Color? iconColor,
    String? actionLabel,
    VoidCallback? onAction,
    double bottomMargin = 16,
    Duration duration = const Duration(seconds: 4),
  }) {
    final messenger = ScaffoldMessenger.of(this)..hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        // Floating snackbars measure from the screen edge, so add the bottom
        // safe area (home indicator) to line up with SafeArea'd footers.
        margin: EdgeInsets.fromLTRB(
          20,
          0,
          20,
          bottomMargin + MediaQuery.paddingOf(this).bottom,
        ),
        duration: duration,
        content: AppToast(
          message: message,
          iconAsset: iconAsset,
          iconColor: iconColor,
          actionLabel: actionLabel,
          onAction: onAction == null
              ? null
              : () {
                  messenger.hideCurrentSnackBar();
                  onAction();
                },
        ),
      ),
    );
  }
}
