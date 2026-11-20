import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/data/models/announcement_model.dart';

/// One announcement card with the faint delivery truck in the end corner
/// (Figma "Banner").
class HomeAnnouncementBanner extends StatelessWidget {
  const HomeAnnouncementBanner({
    required this.announcement,
    required this.decorationColor,
    super.key,
  });

  final AnnouncementModel announcement;
  final Color decorationColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: AppRadius.r20,
        border: Border.all(color: context.colors.surfaceStroke),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: -11.w,
            top: 35.h,
            child: AppSvgIcon(
              Assets.vectorsIcDeliveryTruck84,
              size: 84,
              color: decorationColor,
            ),
          ),
          Padding(
            padding: AppInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.h,
              children: [
                AppText(
                  announcement.title,
                  style: context.typography.title3XS,
                  color: context.colors.brandDeep,
                  maxLines: 1,
                ),
                AppText(
                  announcement.body,
                  style: context.typography.bodyXS,
                  color: context.colors.textSubTitle,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
