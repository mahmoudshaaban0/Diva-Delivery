import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_status_pill.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/formatters/ltr_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/profile/data/models/profile_response_model.dart';
import 'package:limitless_code_template/features/profile/presentation/widgets/profile_avatar.dart';

/// Avatar, name, "كابتن توصيل · #DRV-0142" and the duty pill (Figma
/// "Identity").
class ProfileIdentity extends StatelessWidget {
  const ProfileIdentity({
    required this.profile,
    required this.onChangePhoto,
    this.isPhotoLoading = false,
    super.key,
  });

  final ProfileResponseModel profile;
  final VoidCallback onChangePhoto;
  final bool isPhotoLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      children: [
        ProfileAvatar(
          name: profile.name,
          photoUrl: profile.photoUrl,
          isLoading: isPhotoLoading,
          onTap: onChangePhoto,
        ),
        AppText(
          profile.name,
          style: context.typography.title3XS,
          textAlign: TextAlign.center,
        ),
        AppText(
          context.localizations.profileCaption(LtrFormatter.code(profile.code)),
          style: context.typography.bodyS,
          color: context.colors.textCaption,
          textAlign: TextAlign.center,
        ),
        AppStatusPill(
          label: profile.isOnDuty
              ? context.localizations.profileOnDuty
              : context.localizations.profileOffDuty,
          tone: profile.isOnDuty
              ? AppStatusPillTone.success
              : AppStatusPillTone.error,
          size: AppStatusPillSize.medium,
          // Live state: the courier's day is running.
          pulse: profile.isOnDuty,
        ),
      ],
    );
  }
}
