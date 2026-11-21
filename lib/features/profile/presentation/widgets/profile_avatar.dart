import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton_box.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/formatters/name_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// The courier's photo, or their initials on a tint circle, with the camera
/// badge for changing it (Figma `Courier/Avatar`). Shimmers while
/// [isLoading] (uploading or removing the photo).
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    required this.name,
    required this.onTap,
    this.photoUrl,
    this.isLoading = false,
    super.key,
  });

  final String name;

  /// A network URL, or a local file path (offline fake).
  final String? photoUrl;
  final bool isLoading;
  final VoidCallback onTap;

  /// Design sizes, scaled with `.r`.
  static const double size = 88;
  static const double _badge = 30;

  @override
  Widget build(BuildContext context) {
    final photo = photoUrl;

    return Semantics(
      button: true,
      label: context.localizations.changePhoto,
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child: SizedBox.square(
          dimension: size.r,
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isLoading
                    ? const AppSkeleton(
                        key: ValueKey('loading'),
                        child: AppSkeletonBox.circle(size: size),
                      )
                    : Container(
                        key: ValueKey(photo),
                        width: size.r,
                        height: size.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colors.brandPrimaryTint,
                          // Figma: a 3-px card-colored ring inside the edge.
                          border: Border.all(
                            color: context.colors.surfaceCard,
                            width: 3,
                          ),
                          image: photo == null
                              ? null
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: photo.startsWith('http')
                                      ? CachedNetworkImageProvider(photo)
                                      : FileImage(File(photo)),
                                ),
                        ),
                        child: photo == null
                            ? AppText(
                                NameFormatter.initials(name),
                                style: context.typography.title2XS,
                                color: context.colors.brandPrimary,
                              )
                            : null,
                      ),
              ),
              PositionedDirectional(
                end: 2.r,
                top: 56.r,
                child: Container(
                  width: _badge.r,
                  height: _badge.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.brandPrimary,
                    border: Border.all(
                      color: context.colors.surfaceCard,
                      width: 2,
                    ),
                  ),
                  child: AppSvgIcon(
                    Assets.vectorsIcCamera15,
                    size: 15,
                    color: context.colors.buttonPrimary.label,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
