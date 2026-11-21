import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_banner.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_card.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_row.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_page_header.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_toast.dart';
import 'package:limitless_code_template/core/design_system/organisms/error_state.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/formatters/date_formatter.dart';
import 'package:limitless_code_template/core/formatters/ltr_formatter.dart';
import 'package:limitless_code_template/core/formatters/phone_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/profile/data/models/profile_response_model.dart';
import 'package:limitless_code_template/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:limitless_code_template/features/profile/presentation/bloc/profile_state.dart';
import 'package:limitless_code_template/features/profile/presentation/widgets/profile_personal_info_skeleton.dart';

/// Figma: Flow 07 · "المعلومات الشخصية" (read-only).
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({this.profile, super.key});

  /// The profile the tab already loaded; fetched when null.
  final ProfileResponseModel? profile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<ProfileCubit>();
        final loaded = profile;
        if (loaded != null) {
          cubit.showProfile(loaded);
        } else {
          unawaited(cubit.getProfile());
        }
        return cubit;
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final profile = state.profile;
          final joinedAt = profile?.joinedAt;

          return Scaffold(
            backgroundColor: context.colors.surfaceBg,
            body: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppPageHeader(
                    title: context.localizations.profilePersonalInfo,
                    subtitle: context.localizations.personalInfoSubtitle,
                    onBack: () => context.pop(),
                  ),
                  Expanded(
                    child: profile == null
                        ? state.status == AppStatus.failure
                              ? ErrorState(
                                  message: state.isOffline
                                      ? context
                                            .localizations
                                            .noInternetConnection
                                      : context.localizations.profileLoadError,
                                  retryLabel: context.localizations.retry,
                                  onRetry: () => unawaited(
                                    context.read<ProfileCubit>().getProfile(),
                                  ),
                                )
                              : const ProfilePersonalInfoSkeleton()
                        : SingleChildScrollView(
                            padding:
                                AppInsets.only(
                                  start: 20,
                                  end: 20,
                                  top: 16,
                                  bottom: 24,
                                ).add(
                                  EdgeInsets.only(
                                    bottom: MediaQuery.paddingOf(context)
                                        .bottom,
                                  ),
                                ),
                            child: Column(
                              spacing: 16.h,
                              children: [
                                AppInfoBanner(
                                  message: context
                                      .localizations
                                      .personalInfoReadOnly,
                                  iconAsset: Assets.vectorsIcLockPassword18,
                                ),
                                AppInfoCard(
                                  title:
                                      context.localizations.personalInfoBasic,
                                  rows: [
                                    AppInfoRow(
                                      label: context
                                          .localizations
                                          .personalInfoName,
                                      value: profile.name,
                                    ),
                                    AppInfoRow(
                                      label: context
                                          .localizations
                                          .personalInfoCode,
                                      value: LtrFormatter.code(profile.code),
                                      onCopy: () async {
                                        await Clipboard.setData(
                                          ClipboardData(text: profile.code),
                                        );
                                        if (!context.mounted) return;
                                        context.showToast(
                                          message: context.localizations.copied,
                                        );
                                      },
                                    ),
                                    AppInfoRow(
                                      label: context
                                          .localizations
                                          .personalInfoPhone,
                                      value: LtrFormatter.isolate(
                                        PhoneFormatter.saudiDisplay(
                                          profile.phone,
                                        ),
                                      ),
                                    ),
                                    AppInfoRow(
                                      label: context
                                          .localizations
                                          .personalInfoEmail,
                                      value: LtrFormatter.isolate(
                                        profile.email,
                                      ),
                                    ),
                                  ],
                                ),
                                AppInfoCard(
                                  title: context.localizations.personalInfoWork,
                                  rows: [
                                    AppInfoRow(
                                      label: context
                                          .localizations
                                          .personalInfoWarehouse,
                                      value: profile.warehouse,
                                    ),
                                    AppInfoRow(
                                      label: context
                                          .localizations
                                          .personalInfoSupervisor,
                                      value: profile.supervisor,
                                    ),
                                    AppInfoRow(
                                      label: context
                                          .localizations
                                          .personalInfoVehicle,
                                      value: profile.vehicle,
                                    ),
                                    if (joinedAt != null)
                                      AppInfoRow(
                                        label: context
                                            .localizations
                                            .personalInfoJoined,
                                        value: DateFormatter.formatMonthYear(
                                          joinedAt,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
