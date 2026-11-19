import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_circle_icon_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Flat top bar with a round back button at the start and a centered title
/// (Figma `Courier/Top Bar`). Unlike `AppAppBar` it has no divider and sits
/// on the page background.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({required this.title, this.onBack, super.key});

  final String title;

  /// Defaults to `Navigator.maybePop`.
  final VoidCallback? onBack;

  static const double _height = 56;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: _height,
        child: Padding(
          // Vertical 6 centers the fixed 44 button in the fixed 56 bar.
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6),
          child: Row(
            children: [
              AppCircleIconButton(
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                onPressed: onBack ?? () => Navigator.maybePop(context),
                icon: const AppSvgIcon(
                  Assets.vectorsIcArrowRight22,
                  size: 22,
                  flipInLtr: true,
                ),
              ),
              Expanded(
                child: AppText(
                  title,
                  style: context.typography.title3XS,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
              // Balances the back button so the title stays centered.
              const SizedBox(width: AppCircleIconButton.dimension),
            ],
          ),
        ),
      ),
    );
  }
}
