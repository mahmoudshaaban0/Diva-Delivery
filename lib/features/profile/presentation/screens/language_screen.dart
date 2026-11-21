import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/constants/app_constants.dart';
import 'package:limitless_code_template/core/cubit/locale_cubit.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_radio_row.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_footer_bar.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_page_header.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Figma: Flow 07 · "اللغة". "حفظ" stays disabled until a different
/// language is picked; saving switches the app (`LocaleCubit`) and goes
/// back.
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  /// The picked language code; null until the courier taps a row.
  String? _selected;

  Future<void> _save(String languageCode) async {
    await context.read<LocaleCubit>().setLocale(Locale(languageCode));
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final current = context.watch<LocaleCubit>().state.languageCode;
    final selected = _selected ?? current;
    final canSave = selected != current;

    return Scaffold(
      backgroundColor: context.colors.surfaceBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppPageHeader(
              title: context.localizations.profileLanguage,
              subtitle: context.localizations.languageSubtitle,
              onBack: () => context.pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: AppInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  spacing: 8.h,
                  children: [
                    AppRadioRow(
                      label: context.localizations.languageArabic,
                      selected: selected == AppConstants.arabic,
                      onTap: () =>
                          setState(() => _selected = AppConstants.arabic),
                    ),
                    AppRadioRow(
                      label: context.localizations.languageEnglish,
                      selected: selected == AppConstants.english,
                      onTap: () =>
                          setState(() => _selected = AppConstants.english),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppFooterBar(
        child: AppFilledButton(
          onPressed: canSave ? () => unawaited(_save(selected)) : null,
          child: AppText(
            context.localizations.save,
            style: context.typography.subtitleM.copyWith(
              fontWeight: FontWeight.w700,
            ),
            color: canSave
                ? context.colors.buttonPrimary.label
                : context.colors.buttonDisabledLabel,
          ),
        ),
      ),
    );
  }
}
