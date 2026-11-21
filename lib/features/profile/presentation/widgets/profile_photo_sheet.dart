import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_menu_group.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_menu_row.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_status_sheet.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// What the courier chose in [ProfilePhotoSheet].
enum ProfilePhotoAction { camera, gallery, delete }

/// "صورة الملف الشخصي" sheet: take a photo, choose one, or remove the
/// current one (Figma `Sheet Content/Photo Options`). Pops with the chosen
/// [ProfilePhotoAction], or null on cancel.
class ProfilePhotoSheet extends StatelessWidget {
  const ProfilePhotoSheet({required this.hasPhoto, super.key});

  /// "حذف الصورة" only shows when there's a photo to remove.
  final bool hasPhoto;

  @override
  Widget build(BuildContext context) {
    return AppStatusSheet(
      title: context.localizations.photoSheetTitle,
      subtitle: context.localizations.photoSheetSubtitle,
      content: AppMenuGroup(
        showDividers: false,
        children: [
          AppMenuRow(
            iconAsset: Assets.vectorsIcCamera20,
            title: context.localizations.photoTake,
            showChevron: false,
            onTap: () => Navigator.of(context).pop(ProfilePhotoAction.camera),
          ),
          AppMenuRow(
            iconAsset: Assets.vectorsIcImage20,
            title: context.localizations.photoChoose,
            showChevron: false,
            onTap: () => Navigator.of(context).pop(ProfilePhotoAction.gallery),
          ),
          if (hasPhoto)
            AppMenuRow(
              iconAsset: Assets.vectorsIcDelete20,
              title: context.localizations.photoDelete,
              destructive: true,
              onTap: () => Navigator.of(context).pop(ProfilePhotoAction.delete),
            ),
        ],
      ),
      secondaryLabel: context.localizations.cancel,
      onSecondary: () => Navigator.of(context).pop(),
    );
  }
}
