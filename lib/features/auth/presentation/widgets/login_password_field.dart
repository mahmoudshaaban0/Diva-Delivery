import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_textfield.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Password field with a visibility toggle and the "Forgot password?" link
/// in the label row (Figma `Courier/Input Field` · Password, Show Forgot).
class LoginPasswordField extends StatefulWidget {
  const LoginPasswordField({
    required this.controller,
    required this.focusNode,
    required this.onSubmitted,
    required this.onForgotPassword,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSubmitted;
  final VoidCallback onForgotPassword;

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      label: context.localizations.password,
      labelTrailing: GestureDetector(
        onTap: widget.onForgotPassword,
        child: AppText(
          context.localizations.forgotPassword,
          style: context.typography.subtitleXS,
          color: context.colors.brandPrimary,
        ),
      ),
      hint: context.localizations.passwordHint,
      obscureText: _obscured,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      ltrInput: true,
      validator: (value) =>
          (value ?? '').isEmpty ? context.localizations.passwordRequired : null,
      onFieldSubmitted: (_) => widget.onSubmitted(),
      prefixIcon: const AppSvgIcon(Assets.vectorsIcLockPassword20, size: 20),
      suffixIcon: Semantics(
        button: true,
        label: _obscured
            ? context.localizations.showPassword
            : context.localizations.hidePassword,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() => _obscured = !_obscured),
          child: _obscured
              ? const AppSvgIcon(Assets.vectorsIcViewOff20, size: 20)
              // Figma only ships the "off" glyph.
              : const Icon(Icons.visibility_outlined, size: 20),
        ),
      ),
    );
  }
}
