import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_toast.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_top_bar.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/forgot_password_cubit.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/forgot_password_state.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/auth_resend_link.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/auth_resend_timer.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/forgot_password_heading.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/login_email_field.dart';

/// Figma: Flow 01 · "نسيت كلمة المرور" (34274:6004) and
/// "نسيت كلمة المرور · تم إرسال الرابط" (34274:6073). One screen: the
/// request form switches to the "check your email" state once sent.
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({this.initialEmail = '', super.key});

  /// Pre-fills the field with what was typed on the login screen.
  final String initialEmail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ForgotPasswordCubit>(),
      child: _ForgotPasswordView(initialEmail: initialEmail),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView({required this.initialEmail});

  final String initialEmail;

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  late final _email = TextEditingController(text: widget.initialEmail);

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    unawaited(context.read<ForgotPasswordCubit>().sendLink(_email.text.trim()));
  }

  void _onStateChanged(BuildContext context, ForgotPasswordState state) {
    if (state.status != AppStatus.failure) return;
    final cubit = context.read<ForgotPasswordCubit>();
    context.showToast(
      message: state.isOffline
          ? context.localizations.noInternetConnection
          : state.errorMessage ?? context.localizations.noInternetConnection,
      iconAsset: state.isOffline ? Assets.vectorsIcWifiOff20 : null,
      actionLabel: context.localizations.retry,
      onAction: state.isLinkSent ? () => unawaited(cubit.resend()) : _submit,
      bottomMargin: AppToast.aboveFooterMargin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (a, b) => a.status != b.status,
      listener: _onStateChanged,
      builder: (context, state) {
        final cubit = context.read<ForgotPasswordCubit>();

        return Scaffold(
          backgroundColor: context.colors.surfaceBg,
          appBar: AppTopBar(title: context.localizations.forgotPasswordTitle),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppInsets.only(
                      start: 20,
                      end: 20,
                      top: 32,
                      bottom: 16,
                    ),
                    child: Column(
                      children: [
                        ForgotPasswordHeading(
                          isLinkSent: state.isLinkSent,
                          email: state.email,
                          validForMinutes: state.validForMinutes,
                        ),
                        gapH24,
                        if (!state.isLinkSent)
                          Form(
                            key: _formKey,
                            child: LoginEmailField(
                              controller: _email,
                              onSubmitted: _submit,
                            ),
                          )
                        else if (state.secondsLeft > 0)
                          AuthResendTimer(secondsLeft: state.secondsLeft)
                        else
                          AuthResendLink(
                            question: context.localizations.linkNotReceived,
                            actionLabel: context.localizations.resendLink,
                            onTap: state.canResend
                                ? () => unawaited(cubit.resend())
                                : null,
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: AppInsets.only(
                    start: 20,
                    end: 20,
                    top: 12,
                    bottom: 8,
                  ),
                  child: AppFilledButton(
                    isLoading:
                        state.status == AppStatus.loading || state.isResending,
                    onPressed: !state.isLinkSent
                        ? _submit
                        : () => context.canPop()
                              ? context.pop()
                              : context.goNamed(AppRoutes.login.name),
                    child: AppText(
                      state.isLinkSent
                          ? context.localizations.backToSignIn
                          : context.localizations.sendLink,
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
