import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_note.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_step_indicator.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/permissions/presentation/bloc/location_permission_cubit.dart';
import 'package:limitless_code_template/features/permissions/presentation/bloc/location_permission_state.dart';
import 'package:limitless_code_template/features/permissions/presentation/widgets/location_benefits_card.dart';
import 'package:limitless_code_template/features/permissions/presentation/widgets/location_denied_steps_card.dart';
import 'package:limitless_code_template/features/permissions/presentation/widgets/permission_footer.dart';
import 'package:limitless_code_template/features/permissions/presentation/widgets/permission_heading.dart';

/// Figma: Flow 01 · "إذن الموقع" (34135:946) and "إذن الموقع · مرفوض"
/// (34144:1149). One screen: the request switches to the denied state when
/// the user refuses.
class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LocationPermissionCubit>(),
      child: const _LocationPermissionView(),
    );
  }
}

class _LocationPermissionView extends StatefulWidget {
  const _LocationPermissionView();

  @override
  State<_LocationPermissionView> createState() =>
      _LocationPermissionViewState();
}

class _LocationPermissionViewState extends State<_LocationPermissionView> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    // Re-checks after the user comes back from the system settings.
    _lifecycle = AppLifecycleListener(
      onResume: () =>
          unawaited(context.read<LocationPermissionCubit>().checkStatus()),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationPermissionCubit, LocationPermissionState>(
      listenWhen: (a, b) => a.status != b.status,
      listener: (context, state) {
        if (state.status == AppStatus.success) {
          context.goNamed(AppRoutes.cameraPermission.name);
        }
      },
      builder: (context, state) {
        final cubit = context.read<LocationPermissionCubit>();

        return Scaffold(
          backgroundColor: context.colors.surfaceBg,
          body: SafeArea(
            child: Column(
              children: [
                if (!state.isDenied)
                  Padding(
                    padding: AppInsets.only(
                      start: 20,
                      end: 20,
                      top: 12,
                      bottom: 8,
                    ),
                    child: AppStepIndicator(
                      current: 1,
                      total: 2,
                      label: context.localizations.stepOf(1, 2),
                    ),
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppInsets.only(
                      start: 20,
                      end: 20,
                      top: 24,
                      bottom: 16,
                    ),
                    child: Column(
                      children: [
                        AppIconBadge(
                          assetPath: Assets.vectorsIcLocation36,
                          size: AppIconBadgeSize.large,
                          tone: state.isDenied
                              ? AppIconBadgeTone.warning
                              : AppIconBadgeTone.brand,
                        ),
                        gapH24,
                        PermissionHeading(
                          title: state.isDenied
                              ? context.localizations.locationDeniedTitle
                              : context.localizations.locationPermissionTitle,
                          subtitle: state.isDenied
                              ? context.localizations.locationDeniedSubtitle
                              : context
                                    .localizations
                                    .locationPermissionSubtitle,
                        ),
                        gapH24,
                        if (state.isDenied)
                          const LocationDeniedStepsCard()
                        else
                          const LocationBenefitsCard(),
                        gapH24,
                        AppInfoNote(
                          message: state.isDenied
                              ? context.localizations.locationPrivacyNote
                              : context.localizations.locationAlwaysNote,
                          borderRadius: state.isDenied ? AppRadius.r16 : null,
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.isDenied)
                  PermissionFooter(
                    primaryLabel: context.localizations.openSettings,
                    onPrimary: () => unawaited(cubit.openSettings()),
                    secondaryLabel: context.localizations.tryAgain,
                    secondaryVariant: AppFilledVariant.primarySoft,
                    onSecondary: () => unawaited(cubit.request()),
                    isLoading: state.status == AppStatus.loading,
                  )
                else
                  PermissionFooter(
                    primaryLabel: context.localizations.allowLocationAccess,
                    onPrimary: () => unawaited(cubit.request()),
                    isLoading: state.status == AppStatus.loading,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
