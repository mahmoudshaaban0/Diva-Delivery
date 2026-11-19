import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limitless_code_template/core/cubit/locale_cubit.dart';
import 'package:limitless_code_template/core/cubit/theme_cubit.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_outlined_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/formatters/date_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppInsets.all16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              context.localizations.appTitle,
              style: context.typography.bodyS,
              color: context.colors.textSubTitle,
            ),
            AppFilledButton(
              child: AppText(
                context.localizations.appTitle,
                color: context.colors.buttonPrimary.label,
              ),
              onPressed: () {},
            ),
            gapH24,
            AppOutlinedButton(
              onPressed: () {},
              child: AppText(
                context.localizations.appTitle,
                color: context.colors.brandPrimary,
              ),
            ),
            gapH12,
            SwitchListTile.adaptive(
              title: const AppText('Dark mode'),
              secondary: Icon(
                context.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              value: context.isDarkMode,
              onChanged: (isDark) =>
                  context.read<ThemeCubit>().setDarkMode(isDark: isDark),
            ),
            SwitchListTile.adaptive(
              title: AppText(context.localizations.arabic),
              subtitle: AppText(
                DateFormatter.formatDateWithTime(DateTime.now()),
              ),
              secondary: const Icon(Icons.language),
              value: context.watch<LocaleCubit>().isArabic,
              onChanged: (isArabic) =>
                  context.read<LocaleCubit>().setArabic(isArabic: isArabic),
            ),
          ],
        ),
      ),
    );
  }
}
