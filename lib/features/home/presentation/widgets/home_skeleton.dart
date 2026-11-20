import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton_box.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';

/// Loading placeholder that mirrors the home layout: header, day status,
/// totals, order counts, announcements and the start-day card.
class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: AppInsets.only(start: 20, end: 20, top: 8, bottom: 20),
      child: AppSkeleton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: avatar, name + area, bell.
            Row(
              spacing: 12.w,
              children: [
                const AppSkeletonBox.circle(size: 44),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6.h,
                    children: const [
                      AppSkeletonBox(width: 120, height: 18),
                      AppSkeletonBox(width: 96, height: 12),
                    ],
                  ),
                ),
                const AppSkeletonBox.circle(size: 44),
              ],
            ),
            gapH20,
            // Day status: date chip + title.
            const AppSkeletonBox(
              width: 128,
              height: 24,
              borderRadius: AppRadius.rfull,
            ),
            gapH8,
            const AppSkeletonBox(width: 200, height: 28),
            gapH20,
            // Totals and order counts.
            AppSkeletonBox(height: 98, borderRadius: AppRadius.r16),
            gapH16,
            AppSkeletonBox(height: 90, borderRadius: AppRadius.r20),
            gapH20,
            // Announcements: title + banner.
            const AppSkeletonBox(width: 140, height: 18),
            gapH8,
            AppSkeletonBox(height: 98, borderRadius: AppRadius.r20),
            gapH12,
            // Start-day card.
            AppSkeletonBox(height: 120, borderRadius: AppRadius.r20),
          ],
        ),
      ),
    );
  }
}
