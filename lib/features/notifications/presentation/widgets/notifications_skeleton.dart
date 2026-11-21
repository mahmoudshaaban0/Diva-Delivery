import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton_box.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Loading placeholder for "الإشعارات" (Figma "جارٍ التحميل – الإشعارات"):
/// five row skeletons (`Courier/Skeleton` › Row).
class NotificationsSkeleton extends StatelessWidget {
  const NotificationsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: AppInsets.only(start: 20, end: 20, top: 16, bottom: 24),
      child: Column(
        spacing: 8.h,
        children: [
          for (var i = 0; i < 5; i++)
            Container(
              padding: AppInsets.all(16),
              decoration: BoxDecoration(
                color: context.colors.surfaceCard,
                borderRadius: AppRadius.r16,
                border: Border.all(color: context.colors.surfaceStroke),
              ),
              // Only the shapes shimmer; the outlined row stays still.
              child: AppSkeleton(
                child: Row(
                  spacing: 12.w,
                  children: [
                    AppSkeletonBox(
                      width: 40,
                      height: 40,
                      borderRadius: AppRadius.r12,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          AppSkeletonBox(
                            width: 180,
                            height: 12,
                            borderRadius: AppRadius.rfull,
                          ),
                          AppSkeletonBox(
                            width: 240,
                            height: 10,
                            borderRadius: AppRadius.rfull,
                          ),
                        ],
                      ),
                    ),
                    const AppSkeletonBox(
                      width: 36,
                      height: 10,
                      borderRadius: AppRadius.rfull,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
