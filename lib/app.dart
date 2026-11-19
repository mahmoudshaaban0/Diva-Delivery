import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/constants/app_constants.dart';
import 'package:limitless_code_template/core/cubit/locale_cubit.dart';
import 'package:limitless_code_template/core/cubit/theme_cubit.dart';
import 'package:limitless_code_template/core/design_system/app_theme.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/routing/app_router.dart';
import 'package:limitless_code_template/l10n/app_localizations.dart';

class AppTemplate extends StatelessWidget {
  const AppTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: getIt<ThemeCubit>()),
        BlocProvider<LocaleCubit>.value(value: getIt<LocaleCubit>()),
      ],
      child: Builder(
        builder: (context) {
          final themeMode = context.watch<ThemeCubit>().state;
          final locale = context.watch<LocaleCubit>().state;
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            themeAnimationDuration: const Duration(milliseconds: 400),
            themeAnimationCurve: Curves.easeInOut,
            builder: (context, child) {
              Intl.defaultLocale = Localizations.localeOf(context).languageCode;
              return ResponsiveScope(child: child!);
            },
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale(AppConstants.english),
              Locale(AppConstants.arabic),
            ],
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
