import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Pinned footer with a top hairline, holding the screen's main action
/// (Figma "Footer", e.g. the language screen's "حفظ"). Use it as the
/// `Scaffold.bottomNavigationBar` of a full-screen flow; it keeps clear of
/// the home indicator.
class AppFooterBar extends StatelessWidget {
  const AppFooterBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surfaceBg,
        border: Border(top: BorderSide(color: context.colors.surfaceLine)),
      ),
      child: SafeArea(
        top: false,
        minimum: EdgeInsets.only(bottom: 8.h),
        child: Padding(
          padding: AppInsets.only(start: 20, end: 20, top: 12),
          child: child,
        ),
      ),
    );
  }
}
