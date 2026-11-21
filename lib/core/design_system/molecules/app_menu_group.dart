import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// A card of `AppMenuRow`s with hairline dividers between them, inset past
/// the icon box (Figma settings groups "الحساب" / "أخرى").
class AppMenuGroup extends StatelessWidget {
  const AppMenuGroup({
    required this.children,
    this.showDividers = true,
    super.key,
  });

  final List<Widget> children;

  /// The photo-options sheet lists its rows without dividers.
  final bool showDividers;

  @override
  Widget build(BuildContext context) {
    return Material(
      // Material so the rows' ink splashes show on the card.
      color: context.colors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.r20,
        side: BorderSide(color: context.colors.surfaceStroke),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0 && showDividers)
              Padding(
                // 64 = row padding 16 + icon box 40 + 8, so the line starts
                // under the title.
                padding: AppInsets.only(start: 64, end: 16),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: context.colors.surfaceDivider,
                ),
              ),
            children[i],
          ],
        ],
      ),
    );
  }
}
