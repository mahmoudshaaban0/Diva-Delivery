import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_skeleton_box.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';

/// Loading placeholder that mirrors "تفاصيل الطلب": order info, customer,
/// products, payment and summary cards.
class OrderDetailsSkeleton extends StatelessWidget {
  const OrderDetailsSkeleton({super.key});

  /// Card heights from the design.
  static const _cards = [172.0, 270.0, 317.0, 134.0, 137.0];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: AppInsets.only(start: 20, end: 20, top: 16, bottom: 24),
      child: AppSkeleton(
        child: Column(
          spacing: 12.h,
          children: [
            for (final height in _cards)
              AppSkeletonBox(height: height, borderRadius: AppRadius.r20),
          ],
        ),
      ),
    );
  }
}
