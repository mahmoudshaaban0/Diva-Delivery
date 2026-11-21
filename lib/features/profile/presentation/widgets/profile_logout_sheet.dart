import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_status_sheet.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:limitless_code_template/features/profile/presentation/bloc/profile_state.dart';

/// Logout confirmation (Figma "تأكيد الخروج"). With open orders it turns
/// into the yellow "لديك طلبات مفتوحة" warning (Figma "تأكيد الخروج – طلبات
/// مفتوحة"). Needs the screen's [ProfileCubit] above it
/// (`BlocProvider.value`) to show the spinner while logging out.
class ProfileLogoutSheet extends StatelessWidget {
  const ProfileLogoutSheet({
    required this.openOrders,
    required this.onConfirm,
    super.key,
  });

  final int openOrders;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final hasOpenOrders = openOrders > 0;

    return BlocSelector<ProfileCubit, ProfileState, bool>(
      selector: (state) => state.logoutStatus == AppStatus.loading,
      builder: (context, isLoggingOut) => AppStatusSheet(
        iconAsset: hasOpenOrders
            ? Assets.vectorsIcPackage26
            : Assets.vectorsIcLogout26,
        tone: hasOpenOrders ? AppIconBadgeTone.warning : AppIconBadgeTone.error,
        title: hasOpenOrders
            ? context.localizations.logoutOpenOrdersTitle
            : context.localizations.logoutTitle,
        subtitle: hasOpenOrders
            ? context.localizations.logoutOpenOrdersSubtitle(openOrders)
            : context.localizations.logoutSubtitle,
        primaryLabel: context.localizations.logout,
        primaryVariant: AppFilledVariant.red,
        isPrimaryLoading: isLoggingOut,
        onPrimary: onConfirm,
        secondaryLabel: context.localizations.cancel,
        onSecondary: () => Navigator.of(context).pop(),
      ),
    );
  }
}
