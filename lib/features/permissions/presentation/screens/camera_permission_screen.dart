import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_step_indicator.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/permissions/presentation/bloc/camera_permission_cubit.dart';
import 'package:limitless_code_template/features/permissions/presentation/bloc/camera_permission_state.dart';
import 'package:limitless_code_template/features/permissions/presentation/widgets/camera_benefits_card.dart';
import 'package:limitless_code_template/features/permissions/presentation/widgets/permission_footer.dart';
import 'package:limitless_code_template/features/permissions/presentation/widgets/permission_heading.dart';

/// Figma: Flow 01 · "إذن الكاميرا والصور" (34135:1022), step 2 of 2.
class CameraPermissionScreen extends StatelessWidget {
  const CameraPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CameraPermissionCubit>(),
      child: BlocConsumer<CameraPermissionCubit, CameraPermissionState>(
        listenWhen: (a, b) => a.status != b.status,
        listener: (context, state) {
          if (state.status == AppStatus.success) {
            context.goNamed(AppRoutes.home.name);
          }
        },
        builder: (context, state) {
          final cubit = context.read<CameraPermissionCubit>();

          return Scaffold(
            backgroundColor: context.colors.surfaceBg,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: AppInsets.only(
                      start: 20,
                      end: 20,
                      top: 12,
                      bottom: 8,
                    ),
                    child: AppStepIndicator(
                      current: 2,
                      total: 2,
                      label: context.localizations.stepOf(2, 2),
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
                          const AppIconBadge(
                            assetPath: Assets.vectorsIcCamera36,
                            size: AppIconBadgeSize.large,
                          ),
                          gapH24,
                          PermissionHeading(
                            title: context.localizations.cameraPermissionTitle,
                            subtitle:
                                context.localizations.cameraPermissionSubtitle,
                          ),
                          gapH24,
                          const CameraBenefitsCard(),
                        ],
                      ),
                    ),
                  ),
                  PermissionFooter(
                    primaryLabel: context.localizations.allowAccess,
                    onPrimary: () => unawaited(cubit.request()),
                    secondaryLabel: context.localizations.later,
                    onSecondary: cubit.skip,
                    isLoading: state.status == AppStatus.loading,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
