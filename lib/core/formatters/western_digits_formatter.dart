import 'package:flutter/services.dart';
import 'package:limitless_code_template/core/constants/app_regex.dart';

/// Converts Arabic-Indic digits (٠-٩ and ۰-۹) to 0-9, so numeric fields work
/// with an Arabic keyboard. Put it before `FilteringTextInputFormatter`.
class WesternDigitsFormatter extends TextInputFormatter {
  const WesternDigitsFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAllMapped(AppRegex.easternDigits, (m) {
      final code = m[0]!.codeUnitAt(0);
      final zero = code >= 0x06F0 ? 0x06F0 : 0x0660;
      return '${code - zero}';
    });
    return text == newValue.text ? newValue : newValue.copyWith(text: text);
  }
}
