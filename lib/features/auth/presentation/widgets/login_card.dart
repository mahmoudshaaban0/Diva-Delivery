import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_segmented_control.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/login_state.dart';

/// Card holding the phone/email switch and the active method's fields
/// (Figma "Login Card").
class LoginCard extends StatelessWidget {
  const LoginCard({
    required this.formKey,
    required this.method,
    required this.enabled,
    required this.onMethodChanged,
    required this.fields,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final LoginMethod method;
  final bool enabled;
  final ValueChanged<LoginMethod> onMethodChanged;
  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: AppRadius.r24,
        border: Border.all(color: context.colors.surfaceStroke),
      ),
      child: Form(
        key: formKey,
        child: AbsorbPointer(
          absorbing: !enabled,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                AppSegmentedControl<LoginMethod>(
                  selected: method,
                  onChanged: onMethodChanged,
                  segments: [
                    AppSegment(
                      value: LoginMethod.phone,
                      label: context.localizations.mobileNumber,
                      iconAsset: Assets.vectorsIcSmartPhone18,
                    ),
                    AppSegment(
                      value: LoginMethod.email,
                      label: context.localizations.email,
                      iconAsset: Assets.vectorsIcMail18,
                    ),
                  ],
                ),
                ...fields,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
