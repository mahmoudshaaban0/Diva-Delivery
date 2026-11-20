import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_circle_icon_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_dot.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_vector_image.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Bell button with the unread badge (Figma "Notifications").
///
/// The bell is Figma's two vector pieces (body + clapper) placed at their
/// design positions inside the 22×22 icon box, so it tints with the theme.
class HomeNotificationsButton extends StatelessWidget {
  const HomeNotificationsButton({
    required this.hasUnread,
    required this.onPressed,
    super.key,
  });

  final bool hasUnread;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final color = context.colors.textTitle;

    return AppCircleIconButton(
      tooltip: context.localizations.notifications,
      onPressed: onPressed,
      icon: SizedBox.square(
        dimension: 22.r,
        // Design units inside, scaled as one box.
        child: FittedBox(
          child: SizedBox.square(
            dimension: 22,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 2,
                  top: 1.54,
                  child: AppVectorImage(
                    Assets.vectorsIcNotificationBody,
                    color: color,
                  ),
                ),
                Positioned(
                  left: 7.04,
                  top: 15.75,
                  child: AppVectorImage(
                    Assets.vectorsIcNotificationClapper,
                    color: color,
                  ),
                ),
                if (hasUnread)
                  Positioned(
                    left: 1,
                    top: 0,
                    child: AppDot(color: context.colors.systemRed),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
