import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/cubit/theme_cubit.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_radio_row.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_footer_bar.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_page_header.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Appearance picker, built like the "اللغة" screen: "حفظ" stays disabled
/// until a different mode is picked; saving switches the theme
/// (`ThemeCubit`, animated) and goes back.
class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  /// The picked mode; null until the courier taps a row.
  ThemeMode? _selected;

  Future<void> _save(ThemeMode mode) async {
    await context.read<ThemeCubit>().setThemeMode(mode);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final current = context.watch<ThemeCubit>().state;
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
              title: context.localizations.profileTheme,
              subtitle: context.localizations.themeSubtitle,
              onBack: () => context.pop(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: AppInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  spacing: 8.h,
                  children: [
                    AppRadioRow(
                      label: context.localizations.themeSystem,
                      selected: selected == ThemeMode.system,
                      onTap: () => setState(() => _selected = ThemeMode.system),
                    ),
                    AppRadioRow(
                      label: context.localizations.themeLight,
                      selected: selected == ThemeMode.light,
                      onTap: () => setState(() => _selected = ThemeMode.light),
                    ),
                    AppRadioRow(
                      label: context.localizations.themeDark,
                      selected: selected == ThemeMode.dark,
                      onTap: () => setState(() => _selected = ThemeMode.dark),
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
