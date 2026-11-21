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
/// [action] sits at the end of the title row (e.g. the 44-px sort or call
/// button) and [bottom] below it with a 16 gap (e.g. an `AppSearchBar`).
///
/// Doesn't include the status bar: put it inside a `SafeArea`.
class AppPageHeader extends StatelessWidget {
  const AppPageHeader({
    required this.title,
    this.subtitle,
    this.onBack,
    this.action,
    this.bottom,
    super.key,
  });

  final String title;
  final String? subtitle;

  /// Shows the back button when set.
  final VoidCallback? onBack;
  final Widget? action;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final row = Row(
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
        ?action,
      ],
    );

    return Padding(
      padding: AppInsets.only(start: 20, end: 20, top: 8, bottom: 20),
      child: bottom == null
          ? row
          : Column(spacing: 16.h, children: [row, bottom!]),
    );
  }
}
