import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/formatters/western_digits_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/core/utility/sms_code_retriever.dart';
import 'package:pinput/pinput.dart';

/// Row of round OTP cells (Figma `Courier/OTP Cell`: Empty · Focused ·
/// Filled · Error), built on `Pinput`.
///
/// SMS autofill: iOS through the `oneTimeCode` hint (Pinput default),
/// Android through [SmsCodeRetriever] (User Consent API).
class AppOtpField extends StatelessWidget {
  const AppOtpField({
    required this.controller,
    this.length = 4,
    this.focusNode,
    this.hasError = false,
    this.autofocus = false,
    this.onChanged,
    this.onCompleted,
    super.key,
  });

  final TextEditingController controller;
  final int length;
  final FocusNode? focusNode;

  /// Paints every cell in the error state.
  final bool hasError;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  Widget build(BuildContext context) {
    final base = PinTheme(
      width: 64.r,
      height: 64.r,
      textStyle: context.typography.titleM.copyWith(
        color: context.colors.textTitle,
      ),
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.surfaceStroke),
      ),
    );

    // Digits are entered left-to-right in both languages.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: length,
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        forceErrorState: hasError,
        onChanged: onChanged,
        onCompleted: onCompleted,
        smsRetriever: defaultTargetPlatform == TargetPlatform.android
            ? const SmsCodeRetriever()
            : null,
        inputFormatters: [
          const WesternDigitsFormatter(),
          FilteringTextInputFormatter.digitsOnly,
        ],
        separatorBuilder: (_) => gapW12,
        defaultPinTheme: base,
        submittedPinTheme: base,
        focusedPinTheme: base.copyBorderWith(
          border: Border.all(color: context.colors.brandPrimary, width: 1.5),
        ),
        errorPinTheme: base.copyWith(
          textStyle: base.textStyle?.copyWith(
            color: context.colors.systemRedText,
          ),
          decoration: BoxDecoration(
            color: context.colors.systemRedBg,
            shape: BoxShape.circle,
            border: Border.all(color: context.colors.systemRed, width: 1.5),
          ),
        ),
        cursor: Container(
          width: 2,
          height: 24.r,
          decoration: BoxDecoration(
            color: context.colors.brandPrimary,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        // The screen shows its own error banner.
        errorBuilder: (_, _) => const SizedBox.shrink(),
      ),
    );
  }
}
