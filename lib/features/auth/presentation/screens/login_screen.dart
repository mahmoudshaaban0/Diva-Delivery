import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_inline_alert.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_toast.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/login_cubit.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/login_state.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/login_card.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/login_email_field.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/login_footer.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/login_header.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/login_password_field.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/login_phone_field.dart';
import 'package:limitless_code_template/features/auth/presentation/widgets/login_trust_note.dart';

/// Figma: Flow 01 · "تسجيل الدخول – الجوال" (34135:438) and
/// "تسجيل الدخول – البريد" (34135:627). One screen, switched by the
/// segmented control.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submit(LoginMethod method) {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final cubit = context.read<LoginCubit>();
    switch (method) {
      case LoginMethod.phone:
        unawaited(cubit.sendOtp(_phone.text));
      case LoginMethod.email:
        unawaited(
          cubit.loginWithEmail(
            email: _email.text.trim(),
            password: _password.text,
          ),
        );
    }
  }

  void _onStateChanged(BuildContext context, LoginState state) {
    if (state.status == AppStatus.failure && state.isOffline) {
      context.showToast(
        message: context.localizations.noInternetConnection,
        iconAsset: Assets.vectorsIcWifiOff20,
        actionLabel: context.localizations.retry,
        onAction: () => _submit(state.method),
        bottomMargin: LoginFooter.toastClearance,
      );
      return;
    }
    if (state.status != AppStatus.success) return;
    switch (state.method) {
      case LoginMethod.phone:
        unawaited(
          context.pushNamed(
            AppRoutes.otp.name,
            queryParameters: {
              'phone': state.phone,
              if (state.resendAfterSeconds != null)
                'resendAfter': '${state.resendAfterSeconds}',
            },
          ),
        );
      case LoginMethod.email:
        context.goNamed(AppRoutes.locationPermission.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (a, b) => a.status != b.status,
      listener: _onStateChanged,
      builder: (context, state) {
        final isPhone = state.method == LoginMethod.phone;
        final isLoading = state.status == AppStatus.loading;

        return Scaffold(
          backgroundColor: context.colors.surfaceBg,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppInsets.only(
                      start: 20,
                      end: 20,
                      top: 8,
                      bottom: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LoginHeader(
                          onSupport: () {
                            // NOTE: opens the support flow (Flow 04 ·
                            // "التواصل مع الدعم") once it's built.
                          },
                        ),
                        gapH24,
                        LoginCard(
                          formKey: _formKey,
                          method: state.method,
                          enabled: !isLoading,
                          onMethodChanged: context
                              .read<LoginCubit>()
                              .selectMethod,
                          fields: isPhone
                              ? [
                                  LoginPhoneField(
                                    key: const ValueKey('phone'),
                                    controller: _phone,
                                    onSubmitted: () => _submit(state.method),
                                  ),
                                ]
                              : [
                                  LoginEmailField(
                                    key: const ValueKey('email'),
                                    controller: _email,
                                    onSubmitted: _passwordFocus.requestFocus,
                                  ),
                                  LoginPasswordField(
                                    key: const ValueKey('password'),
                                    controller: _password,
                                    focusNode: _passwordFocus,
                                    onSubmitted: () => _submit(state.method),
                                    onForgotPassword: () => unawaited(
                                      context.pushNamed(
                                        AppRoutes.forgotPassword.name,
                                        queryParameters: {
                                          'email': _email.text.trim(),
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                        ),
                        if (state.status == AppStatus.failure &&
                            !state.isOffline &&
                            state.errorMessage != null) ...[
                          gapH16,
                          AppInlineAlert(message: state.errorMessage!),
                        ],
                        gapH16,
                        const LoginTrustNote(),
                      ],
                    ),
                  ),
                ),
                LoginFooter(
                  label: isPhone
                      ? context.localizations.sendOtp
                      : context.localizations.signIn,
                  isLoading: isLoading,
                  onPressed: () => _submit(state.method),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
