import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_otp_field.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_top_bar.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/otp_cubit.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/otp_state.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/auth_resend_link.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/auth_resend_timer.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/otp_error_alert.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/otp_heading.dart';

/// Figma: Flow 01 · "رمز التحقق" (34135:724) and "رمز التحقق – خطأ"
/// (34135:783).
class OtpScreen extends StatelessWidget {
  const OtpScreen({required this.phone, this.resendAfterSeconds, super.key});

  /// 9-digit national number (5XXXXXXXX).
  final String phone;
  final int? resendAfterSeconds;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OtpCubit>(param1: phone, param2: resendAfterSeconds),
      child: _OtpView(phone: phone),
    );
  }
}

class _OtpView extends StatefulWidget {
  const _OtpView({required this.phone});

  final String phone;

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  final _code = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _code.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _verify() {
    if (_code.text.length < OtpCubit.codeLength) {
      _focus.requestFocus();
      return;
    }
    unawaited(context.read<OtpCubit>().verify(_code.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listenWhen: (a, b) => a.status != b.status,
      listener: (context, state) {
        if (state.status == AppStatus.success) {
          context.goNamed(AppRoutes.locationPermission.name);
        }
      },
      builder: (context, state) {
        final failed = state.status == AppStatus.failure;
        final cubit = context.read<OtpCubit>();

        return Scaffold(
          backgroundColor: context.colors.surfaceBg,
          appBar: AppTopBar(title: context.localizations.otpTitle),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                    child: Column(
                      children: [
                        OtpHeading(
                          phone: widget.phone,
                          codeLength: OtpCubit.codeLength,
                          isCodeInvalid: state.isCodeInvalid,
                        ),
                        gapH24,
                        AppOtpField(
                          controller: _code,
                          focusNode: _focus,
                          autofocus: true,
                          hasError: state.isCodeInvalid,
                          onChanged: (_) => cubit.codeChanged(),
                          onCompleted: (_) => _verify(),
                        ),
                        gapH24,
                        if (failed) ...[OtpErrorAlert(state: state), gapH24],
                        if (state.secondsLeft > 0 && !failed)
                          AuthResendTimer(secondsLeft: state.secondsLeft)
                        else
                          AuthResendLink(
                            question: context.localizations.otpNotReceived,
                            actionLabel: context.localizations.otpResend,
                            onTap: state.canResend
                                ? () => unawaited(cubit.resend())
                                : null,
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: AppFilledButton(
                    isLoading: state.status == AppStatus.loading,
                    onPressed: _verify,
                    child: AppText(
                      state.isCodeInvalid
                          ? context.localizations.otpVerifyAgain
                          : context.localizations.otpVerify,
                      style: context.typography.subtitleM.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      color: context.colors.buttonPrimary.label,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
