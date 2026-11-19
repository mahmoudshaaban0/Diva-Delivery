import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/app_regex.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_textfield.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Email field (Figma `Courier/Input Field` · Email).
class LoginEmailField extends StatelessWidget {
  const LoginEmailField({
    required this.controller,
    required this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: context.localizations.email,
      hint: context.localizations.emailHint,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      ltrInput: true,
      validator: (value) => AppRegex.email.hasMatch(value?.trim() ?? '')
          ? null
          : context.localizations.emailInvalid,
      onFieldSubmitted: (_) => onSubmitted(),
      prefixIcon: const AppSvgIcon(Assets.vectorsIcMail20, size: 20),
    );
  }
}
