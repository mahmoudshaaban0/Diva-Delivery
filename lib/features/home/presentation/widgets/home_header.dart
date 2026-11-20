import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_notifications_button.dart';

/// Avatar, name and area, with the notifications button (Figma "Header").
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.name,
    required this.area,
    required this.onNotifications,
    this.hasUnreadNotifications = false,
    super.key,
  });

  final String name;
  final String area;
  final VoidCallback onNotifications;
  final bool hasUnreadNotifications;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colors.buttonNeutral.soft,
            borderRadius: AppRadius.rfull,
          ),
          child: AppText(
            name.isEmpty ? '' : name.characters.first,
            style: context.typography.title2XS,
          ),
        ),
        12.hs,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.h,
            children: [
              AppText(name, style: context.typography.title2XS, maxLines: 1),
              Row(
                spacing: 4.w,
                children: [
                  AppSvgIcon(
                    Assets.vectorsIcLocation14,
                    size: 14,
                    color: context.colors.textTitle,
                  ),
                  Flexible(
                    child: AppText(
                      area,
                      style: context.typography.bodyXS,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        HomeNotificationsButton(
          hasUnread: hasUnreadNotifications,
          onPressed: onNotifications,
        ),
      ],
    );
  }
}
