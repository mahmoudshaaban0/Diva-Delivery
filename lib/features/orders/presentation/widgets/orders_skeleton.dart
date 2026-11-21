import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton_box.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';

/// Loading placeholder that mirrors the orders list: the pinned order card,
/// the group title and three order cards.
class OrdersSkeleton extends StatelessWidget {
  const OrdersSkeleton({this.showActiveCard = true, super.key});

  /// The pinned card only exists on the "الحالية" tab.
  final bool showActiveCard;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: AppInsets.symmetric(horizontal: 20, vertical: 16),
      child: AppSkeleton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showActiveCard) ...[
              AppSkeletonBox(height: 224, borderRadius: AppRadius.r24),
              gapH20,
            ],
            const AppSkeletonBox(width: 220, height: 18),
            for (var i = 0; i < 3; i++) ...[
              10.vs,
              AppSkeletonBox(height: 167, borderRadius: AppRadius.r20),
            ],
          ],
        ),
      ),
    );
  }
}
