import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/constants/app_constants.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/cubit/theme_cubit.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_menu_group.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_menu_row.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_bottom_sheet.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_page_header.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_toast.dart';
import 'package:limitless_code_template/core/design_system/organisms/error_state.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/services/image_picker_service.dart';
import 'package:limitless_code_template/core/services/permission_service.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:limitless_code_template/features/profile/presentation/bloc/profile_state.dart';
import 'package:limitless_code_template/features/profile/presentation/widgets/profile_identity.dart';
import 'package:limitless_code_template/features/profile/presentation/widgets/profile_logout_sheet.dart';
import 'package:limitless_code_template/features/profile/presentation/widgets/profile_photo_sheet.dart';
import 'package:limitless_code_template/features/profile/presentation/widgets/profile_skeleton.dart';

/// Figma: Flow 07 · "الملف الشخصي" (profile tab) with the "تغيير الصورة"
/// sheet and the "تأكيد الخروج" sheets (plain and with open orders).
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileCubit _cubit = getIt<ProfileCubit>();

  /// Re-reads the location permission when the courier comes back from the
  /// system settings.
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    unawaited(_cubit.getProfile());
    _lifecycle = AppLifecycleListener(
      onResume: () => unawaited(_cubit.refreshLocationAccess()),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    unawaited(_cubit.close());
    super.dispose();
  }

  Future<void> _onChangePhoto() async {
    final profile = _cubit.state.profile;
    if (profile == null) return;
    final action = await showAppBottomSheet<ProfilePhotoAction>(
      context: context,
      size: AppSheetSize.wrap,
      child: ProfilePhotoSheet(hasPhoto: profile.photoUrl != null),
    );
    switch (action) {
      case ProfilePhotoAction.camera:
        await _cubit.changePhoto(ImagePickSource.camera);
      case ProfilePhotoAction.gallery:
        await _cubit.changePhoto(ImagePickSource.gallery);
      case ProfilePhotoAction.delete:
        await _cubit.deletePhoto();
      case null:
        break;
    }
  }

  Future<void> _onLogout() async {
    final profile = _cubit.state.profile;
    if (profile == null) return;
    await showAppBottomSheet<void>(
      context: context,
      size: AppSheetSize.wrap,
      child: BlocProvider.value(
        value: _cubit,
        child: ProfileLogoutSheet(
          openOrders: profile.openOrders,
          onConfirm: () => unawaited(_cubit.logout()),
        ),
      ),
    );
  }

  void _onLogoutStatus(BuildContext context, ProfileState state) {
    switch (state.logoutStatus) {
      case AppStatus.success:
        // Replaces the whole stack, the open sheet included.
        context.goNamed(AppRoutes.login.name);
      case AppStatus.failure:
        Navigator.of(context).pop(); // The logout sheet.
        context.showToast(
          message: state.isOffline
              ? context.localizations.noInternetConnection
              : context.localizations.logoutError,
          iconAsset: state.isOffline ? Assets.vectorsIcWifiOff20 : null,
        );
      case AppStatus.initial:
      case AppStatus.loading:
        break;
    }
  }

  void _onPhotoStatus(BuildContext context, ProfileState state) {
    switch (state.photoStatus) {
      case AppStatus.success:
        context.showToast(
          message: state.profile?.photoUrl != null
              ? context.localizations.photoUpdated
              : context.localizations.photoRemoved,
        );
      case AppStatus.failure:
        context.showToast(
          message: state.isOffline
              ? context.localizations.noInternetConnection
              : context.localizations.photoUpdateError,
          iconAsset: state.isOffline ? Assets.vectorsIcWifiOff20 : null,
        );
      case AppStatus.initial:
      case AppStatus.loading:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: MultiBlocListener(
        listeners: [
          BlocListener<ProfileCubit, ProfileState>(
            listenWhen: (a, b) => a.logoutStatus != b.logoutStatus,
            listener: _onLogoutStatus,
          ),
          BlocListener<ProfileCubit, ProfileState>(
            listenWhen: (a, b) => a.photoStatus != b.photoStatus,
            listener: _onPhotoStatus,
          ),
        ],
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final profile = state.profile;

            return Scaffold(
              backgroundColor: context.colors.surfaceBg,
              body: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppPageHeader(
                      title: context.localizations.profileTitle,
                      subtitle: context.localizations.profileSubtitle,
                    ),
                    Expanded(
                      child: profile == null
                          ? state.status == AppStatus.failure
                                ? ErrorState(
                                    message: state.isOffline
                                        ? context
                                              .localizations
                                              .noInternetConnection
                                        : context
                                              .localizations
                                              .profileLoadError,
                                    retryLabel: context.localizations.retry,
                                    onRetry: () =>
                                        unawaited(_cubit.getProfile()),
                                  )
                                : const ProfileSkeleton()
                          : RefreshIndicator.adaptive(
                              onRefresh: _cubit.getProfile,
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: AppInsets.only(
                                  start: 20,
                                  end: 20,
                                  top: 16,
                                  bottom: 24,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  spacing: 16.h,
                                  children: [
                                    ProfileIdentity(
                                      profile: profile,
                                      isPhotoLoading:
                                          state.photoStatus ==
                                          AppStatus.loading,
                                      onChangePhoto: () =>
                                          unawaited(_onChangePhoto()),
                                    ),
                                    AppMenuGroup(
                                      children: [
                                        AppMenuRow(
                                          iconAsset: Assets.vectorsIcUser20,
                                          title: context
                                              .localizations
                                              .profilePersonalInfo,
                                          onTap: () => unawaited(
                                            context.pushNamed(
                                              AppRoutes.personalInfo.name,
                                              extra: profile,
                                            ),
                                          ),
                                        ),
                                        AppMenuRow(
                                          iconAsset:
                                              Assets.vectorsIcLanguages20,
                                          title: context
                                              .localizations
                                              .profileLanguage,
                                          value:
                                              Localizations.localeOf(context)
                                                      .languageCode ==
                                                  AppConstants.arabic
                                              ? context
                                                    .localizations
                                                    .languageArabic
                                              : context
                                                    .localizations
                                                    .languageEnglish,
                                          onTap: () => unawaited(
                                            context.pushNamed(
                                              AppRoutes.language.name,
                                            ),
                                          ),
                                        ),
                                        AppMenuRow(
                                          iconAsset: Assets.vectorsIcMoon20,
                                          title: context
                                              .localizations
                                              .profileTheme,
                                          value: switch (context
                                              .watch<ThemeCubit>()
                                              .state) {
                                            ThemeMode.system =>
                                              context.localizations.themeSystem,
                                            ThemeMode.light =>
                                              context.localizations.themeLight,
                                            ThemeMode.dark =>
                                              context.localizations.themeDark,
                                          },
                                          onTap: () => unawaited(
                                            context.pushNamed(
                                              AppRoutes.theme.name,
                                            ),
                                          ),
                                        ),
                                        AppMenuRow(
                                          iconAsset: Assets.vectorsIcLocation20,
                                          title: context
                                              .localizations
                                              .profileLocationPermission,
                                          value: switch (state.locationAccess) {
                                            LocationAccess.always =>
                                              context
                                                  .localizations
                                                  .locationAccessAlways,
                                            LocationAccess.whileInUse =>
                                              context
                                                  .localizations
                                                  .locationAccessWhileInUse,
                                            LocationAccess.denied =>
                                              context
                                                  .localizations
                                                  .locationAccessOff,
                                            null => null,
                                          },
                                          onTap: () => unawaited(
                                            _cubit.openLocationSettings(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    AppMenuGroup(
                                      children: [
                                        AppMenuRow(
                                          iconAsset:
                                              Assets.vectorsIcCustomerSupport20,
                                          title: context
                                              .localizations
                                              .profileSupport,
                                          // NOTE: opens support once its
                                          // channel (chat / phone) is decided.
                                          onTap: () => context.showToast(
                                            message: context
                                                .localizations
                                                .comingSoon,
                                          ),
                                        ),
                                        AppMenuRow(
                                          iconAsset: Assets.vectorsIcLogout20,
                                          title: context.localizations.logout,
                                          destructive: true,
                                          onTap: () => unawaited(_onLogout()),
                                        ),
                                      ],
                                    ),
                                    AppText(
                                      context.localizations.appVersion(
                                        AppConstants.appVersion,
                                      ),
                                      style: context.typography.bodyXS,
                                      color: context.colors.textCaption,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
