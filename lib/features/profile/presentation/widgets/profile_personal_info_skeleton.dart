import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton_box.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';

/// Loading placeholder for "المعلومات الشخصية": the read-only banner and the
/// two info cards. Only shown when the screen is opened without a loaded
/// profile (e.g. a deep link).
class ProfilePersonalInfoSkeleton extends StatelessWidget {
  const ProfilePersonalInfoSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: AppInsets.only(start: 20, end: 20, top: 16, bottom: 24),
      child: AppSkeleton(
        child: Column(
          children: [
            AppSkeletonBox(height: 46, borderRadius: AppRadius.r12),
            gapH16,
            AppSkeletonBox(height: 190, borderRadius: AppRadius.r20),
            gapH16,
            AppSkeletonBox(height: 190, borderRadius: AppRadius.r20),
          ],
        ),
      ),
    );
  }
}
