import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.label,
    this.labelTrailing,
    this.hint,
    this.controller,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.autofillHints,
    this.ltrInput = false,
    this.alignLeft = false,
    super.key,
  });

  final String? label;

  /// Shown at the end of the label row (e.g. a "Forgot password?" link).
  final Widget? labelTrailing;
  final String? hint;
  final TextEditingController? controller;
  final String? errorText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  /// Types the value left-to-right (emails, passwords, numbers) while
  /// keeping it at the reading start, so in Arabic it sits next to the
  /// leading icon like the RTL design.
  final bool ltrInput;

  /// Starts the cursor and text at the physical left in both languages.
  /// Only the phone field uses it, so the number follows `+966`.
  final bool alignLeft;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: AppRadius.rfull,
          borderSide: BorderSide(color: color, width: width),
        );

    final iconColor = WidgetStateColor.resolveWith(
      (states) => states.contains(WidgetState.focused)
          ? context.colors.textTitle
          : context.colors.surfaceIconInactive,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  label!,
                  style: context.typography.subtitleS.copyWith(
                    color: context.colors.textTitle,
                  ),
                ),
              ),
              ?labelTrailing,
            ],
          ),
          gapH8,
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatters,
          autofillHints: autofillHints,
          textDirection: ltrInput || alignLeft ? TextDirection.ltr : null,
          textAlign: alignLeft || !ltrInput
              ? TextAlign.start
              : Directionality.of(context) == TextDirection.rtl
              ? TextAlign.right
              : TextAlign.left,
          style: context.typography.bodyM.copyWith(
            color: context.colors.textTitle,
          ),
          cursorColor: context.colors.brandPrimary,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: context.typography.bodyM.copyWith(
              color: context.colors.textCaption,
            ),
            helperText: helperText,
            helperStyle: context.typography.bodyXS.copyWith(
              color: context.colors.textCaption,
            ),
            errorText: errorText,
            errorStyle: context.typography.bodyXS.copyWith(
              color: context.colors.systemRedText,
            ),
            filled: true,
            fillColor: WidgetStateColor.resolveWith(
              (states) => states.contains(WidgetState.error)
                  ? context.colors.systemRedBg
                  : context.colors.surfaceCard,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 24,
                      end: 12,
                    ),
                    child: prefixIcon,
                  ),
            suffixIcon: suffixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 12,
                      end: 24,
                    ),
                    child: suffixIcon,
                  ),
            prefixIconConstraints: const BoxConstraints(),
            suffixIconConstraints: const BoxConstraints(),
            prefixIconColor: iconColor,
            suffixIconColor: iconColor,
            enabledBorder: border(context.colors.surfaceStroke),
            focusedBorder: border(context.colors.brandPrimary, 1.5),
            errorBorder: border(context.colors.systemRed, 1.5),
            focusedErrorBorder: border(context.colors.systemRed, 1.5),
          ),
        ),
      ],
    );
  }
}
