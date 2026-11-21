import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton_box.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';

/// Loading placeholder that mirrors the profile tab: avatar, name, caption,
/// duty pill, the two settings groups and the version line.
class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: AppInsets.only(start: 20, end: 20, top: 16, bottom: 24),
      child: AppSkeleton(
        child: Column(
          children: [
            const AppSkeletonBox.circle(size: 88),
            gapH8,
            const AppSkeletonBox(width: 110, height: 20),
            gapH8,
            const AppSkeletonBox(width: 160, height: 16),
            gapH8,
            const AppSkeletonBox(
              width: 84,
              height: 26,
              borderRadius: AppRadius.rfull,
            ),
            gapH16,
            // "Account" group: 3 rows of 56 + dividers.
            AppSkeletonBox(height: 170, borderRadius: AppRadius.r20),
            gapH16,
            // "Other" group: 2 rows.
            AppSkeletonBox(height: 113, borderRadius: AppRadius.r20),
            gapH16,
            const AppSkeletonBox(width: 72, height: 14),
          ],
        ),
      ),
    );
  }
}
