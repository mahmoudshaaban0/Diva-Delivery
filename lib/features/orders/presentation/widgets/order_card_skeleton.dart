import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton_box.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// One order-card placeholder (Figma `Courier/Skeleton` › Order Card):
/// name and code bars with the status chip, two meta bars and the footer.
/// The bars shimmer on their own (`AppSkeleton` inside the card).
class OrderCardSkeleton extends StatelessWidget {
  const OrderCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: AppRadius.r20,
        border: Border.all(color: context.colors.surfaceStroke),
      ),
      // Only the bars shimmer; the outlined card stays still.
      child: AppSkeleton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: const [
                    AppSkeletonBox(
                      width: 140,
                      height: 14,
                      borderRadius: AppRadius.rfull,
                    ),
                    AppSkeletonBox(
                      width: 96,
                      height: 10,
                      borderRadius: AppRadius.rfull,
                    ),
                  ],
                ),
                const AppSkeletonBox(
                  width: 72,
                  height: 24,
                  borderRadius: AppRadius.rfull,
                ),
              ],
            ),
            const AppSkeletonBox(
              width: 260,
              height: 10,
              borderRadius: AppRadius.rfull,
            ),
            const AppSkeletonBox(
              width: 200,
              height: 10,
              borderRadius: AppRadius.rfull,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppSkeletonBox(
                  width: 110,
                  height: 16,
                  borderRadius: AppRadius.rfull,
                ),
                AppSkeletonBox(
                  width: 80,
                  height: 16,
                  borderRadius: AppRadius.rfull,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
