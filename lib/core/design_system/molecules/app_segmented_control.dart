import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

class AppSegment<T> {
  const AppSegment({
    required this.value,
    required this.label,
    required this.iconAsset,
  });

  final T value;
  final String label;

  /// An 18-px SVG icon shown before the label.
  final String iconAsset;
}

/// Pill-shaped segmented switch (Figma `Courier/Segment Item` inside a
/// `Brand/Primary-tint` track). Segments share the width equally.
class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    required this.segments,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<AppSegment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  /// Fixed component height, not scaled.
  static const double _itemHeight = 44;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.brandPrimaryTint,
        borderRadius: AppRadius.rfull,
      ),
      child: Row(
        spacing: 4,
        children: [
          for (final segment in segments)
            Expanded(
              child: _SegmentItem(
                segment: segment,
                isSelected: segment.value == selected,
                onTap: () => onChanged(segment.value),
              ),
            ),
        ],
      ),
    );
  }
}

class _SegmentItem<T> extends StatelessWidget {
  const _SegmentItem({
    required this.segment,
    required this.isSelected,
    required this.onTap,
  });

  final AppSegment<T> segment;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected
        ? context.colors.brandDeep
        : context.colors.textSubTitle;

    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          height: AppSegmentedControl._itemHeight,
          decoration: BoxDecoration(
            color: isSelected
                ? context.colors.surfaceBg
                : context.colors.brandPrimaryTint,
            borderRadius: AppRadius.rfull,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              AppSvgIcon(segment.iconAsset, size: 18, color: foreground),
              Flexible(
                child: Text(
                  segment.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.subtitleS.copyWith(
                    color: foreground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
