import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_circle_icon_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Page title with a description and an optional round back button at the
/// start (Figma `Courier/Page Header`), e.g. "الملف الشخصي · حسابك وإعدادات
/// التطبيق". Tab screens leave out [onBack]; inner screens pass it.
///
/// Doesn't include the status bar: put it inside a `SafeArea`.
class AppPageHeader extends StatelessWidget {
  const AppPageHeader({
    required this.title,
    this.subtitle,
    this.onBack,
    super.key,
  });

  final String title;
  final String? subtitle;

  /// Shows the back button when set.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.only(start: 20, end: 20, top: 8, bottom: 20),
      child: Row(
        spacing: 12.w,
        children: [
          if (onBack != null)
            AppCircleIconButton(
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: onBack,
              icon: const AppSvgIcon(
                Assets.vectorsIcArrowRight22,
                size: 22,
                flipInLtr: true,
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                AppText(title, style: context.typography.titleS),
                if (subtitle != null)
                  AppText(
                    subtitle!,
                    style: context.typography.bodyS,
                    color: context.colors.textBody,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
