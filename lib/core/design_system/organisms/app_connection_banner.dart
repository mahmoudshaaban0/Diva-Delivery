import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Which connection banner to show; [none] hides it.
enum AppConnectionStatus {
  none,

  /// Dark "غير متصل · تعرض آخر بيانات محفوظة 12:40 م".
  offline,

  /// Green "عاد الاتصال · تمت مزامنة البيانات" (the screen hides it after
  /// ~3 s).
  restored,
}

/// Connection strip under the header (Figma `Courier/Connection Banner`:
/// Offline · Online). Animates in and out; [AppConnectionStatus.none]
/// takes no space.
class AppConnectionBanner extends StatelessWidget {
  const AppConnectionBanner({
    required this.status,
    required this.message,
    this.bottomSpacing = 0,
    super.key,
  });

  final AppConnectionStatus status;

  /// The text for the current [status].
  final String message;

  /// Gap under the strip while it's visible (collapses with it).
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final isOffline = status == AppConnectionStatus.offline;
    // Inverted surface so the offline strip stays dark-on-light and
    // light-on-dark in both themes.
    final background = isOffline
        ? context.colors.textTitle
        : context.colors.systemGreenBg;
    final foreground = isOffline
        ? context.colors.surfaceBg
        : context.colors.systemGreenText;

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      alignment: AlignmentDirectional.topCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: status == AppConnectionStatus.none
            ? const SizedBox(width: double.infinity)
            : Padding(
                key: ValueKey(status),
                padding: EdgeInsets.only(bottom: bottomSpacing.h),
                child: Container(
                  width: double.infinity,
                  padding: AppInsets.symmetric(
                    horizontal: 20,
                    vertical: isOffline ? 8 : 10,
                  ),
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: AppRadius.r16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8.w,
                    children: [
                      AppSvgIcon(
                        isOffline
                            ? Assets.vectorsIcWifiOff16
                            : Assets.vectorsIcTick16,
                        size: 16,
                        color: foreground,
                      ),
                      Flexible(
                        child: AppText(
                          message,
                          style: context.typography.subtitleXS,
                          color: foreground,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
