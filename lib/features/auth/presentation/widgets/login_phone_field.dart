import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limitless_code_template/core/constants/app_regex.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_textfield.dart';
import 'package:limitless_code_template/core/formatters/western_digits_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/login_country_code.dart';

/// Saudi mobile number field: `+966` always on the left, 9 digits typed LTR
/// (Figma `Courier/Input Field` · Phone).
class LoginPhoneField extends StatelessWidget {
  const LoginPhoneField({
    required this.controller,
    required this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    // `+966` stays on the physical left in both languages, right before the
    // number. Prefix = start and suffix = end flip with the language, so it
    // goes in the prefix for English (LTR) and the suffix for Arabic (RTL).
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    const countryCode = LoginCountryCode();
    const phoneIcon = AppSvgIcon(Assets.vectorsIcSmartPhone20, size: 20);

    return AppTextField(
      controller: controller,
      label: context.localizations.mobileNumber,
      hint: context.localizations.phoneHint,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.telephoneNumberNational],
      alignLeft: true,
      inputFormatters: [
        const WesternDigitsFormatter(),
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
      ],
      validator: (value) => AppRegex.saudiMobile.hasMatch(value ?? '')
          ? null
          : context.localizations.phoneInvalid,
      onFieldSubmitted: (_) => onSubmitted(),
      prefixIcon: isRtl ? phoneIcon : countryCode,
      suffixIcon: isRtl ? countryCode : phoneIcon,
    );
  }
}
