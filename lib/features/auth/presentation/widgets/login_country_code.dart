import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_vertical_divider.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/formatters/phone_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// `+966` with a divider between it and the typed number. Always laid out
/// LTR so it reads `+966 |` in both languages.
class LoginCountryCode extends StatelessWidget {
  const LoginCountryCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 12.w,
        children: [
          Text(
            PhoneFormatter.countryCode,
            style: context.typography.subtitleM.copyWith(
              color: context.colors.textTitle,
            ),
          ),
          const AppVerticalDivider(height: 24),
        ],
      ),
    );
  }
}
