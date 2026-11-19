import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// 44×44 round icon button on a soft fill (Figma top-bar "Back" / "Support").
///
/// The size is a fixed touch target, so it isn't scaled.
class AppCircleIconButton extends StatelessWidget {
  const AppCircleIconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    super.key,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String tooltip;

  static const double dimension = 44;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: context.colors.brandPrimaryTint,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.rfull),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox.square(
            dimension: dimension,
            child: Center(
              child: IconTheme.merge(
                data: IconThemeData(color: context.colors.textTitle),
                child: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
