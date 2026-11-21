import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Pill search field (Figma `Courier/Search Bar`): "Default" shows the
/// hint; "Filled" darkens the icon, adds a clear button at the end and a
/// 1.5-px primary border.
///
/// Fixed 48 height, like the other inputs.
class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.clearTooltip,
    this.inputFormatters,
    super.key,
  });

  /// Owned by the screen (dispose it there).
  final TextEditingController controller;
  final String hintText;

  /// Also called with an empty string when the clear button is tapped.
  final ValueChanged<String> onChanged;
  final String? clearTooltip;

  /// e.g. `WesternDigitsFormatter` so Arabic digits match order numbers.
  final List<TextInputFormatter>? inputFormatters;

  static const double height = 48;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final isFilled = value.text.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: height,
          padding: AppInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: context.colors.surfaceCard,
            borderRadius: AppRadius.rfull,
            border: Border.all(
              color: isFilled
                  ? context.colors.brandPrimary
                  : context.colors.surfaceStroke,
              width: isFilled ? 1.5 : 1,
            ),
          ),
          child: Row(
            spacing: 8.w,
            children: [
              AppSvgIcon(
                Assets.vectorsIcSearch20,
                size: 20,
                color: isFilled
                    ? context.colors.textTitle
                    : context.colors.textCaption,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  inputFormatters: inputFormatters,
                  textInputAction: TextInputAction.search,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  style: context.typography.bodyM.copyWith(
                    color: context.colors.textTitle,
                  ),
                  cursorColor: context.colors.brandPrimary,
                  decoration: InputDecoration.collapsed(
                    hintText: hintText,
                    hintStyle: context.typography.bodyM.copyWith(
                      color: context.colors.textCaption,
                    ),
                  ),
                ),
              ),
              if (isFilled)
                Semantics(
                  button: true,
                  label: clearTooltip,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      controller.clear();
                      onChanged('');
                    },
                    child: AppSvgIcon(
                      Assets.vectorsIcCancel18,
                      size: 18,
                      color: context.colors.textCaption,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
