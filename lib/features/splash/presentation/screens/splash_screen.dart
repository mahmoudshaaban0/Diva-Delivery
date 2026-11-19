import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/constants/app_constants.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_logo.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/splash/presentation/widgets/splash_loading_bar.dart';

/// Figma: Flow 01 · "شاشة البداية" (node 34135:369).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _duration = Duration(milliseconds: 2200);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // NOTE: once sessions are stored, route to home when already signed in.
    _timer = Timer(_duration, () {
      if (mounted) context.goNamed(AppRoutes.login.name);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        // Figma binds this to Brand/Primary, which turns light in the derived
        // dark palette; the scrim token stays dark in both themes so the
        // white wordmark always reads.
        backgroundColor: context.colors.surfaceScrim,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppLogo.hero(color: context.colors.textAlwaysWhite),
                      gapH24,
                      AppText(
                        context.localizations.splashTagline,
                        textAlign: TextAlign.center,
                        color: context.colors.textAlwaysWhiteMeta,
                      ),
                      gapH24,
                      SplashLoadingBar(
                        track: context.colors.surfaceGlass,
                        value: context.colors.textAlwaysWhite,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: AppText(
                  context.localizations.splashFooter(AppConstants.appVersion),
                  style: context.typography.bodyXS,
                  color: context.colors.textAlwaysWhiteMeta,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
