import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_network_image.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// A 96-high proof-of-delivery photo with its caption ("صورة المنزل" /
/// "صورة الطلب"). Shows an image icon when there is no photo.
class OrderProofPhoto extends StatelessWidget {
  const OrderProofPhoto({required this.caption, this.url, super.key});

  final String? url;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final photo = url;

    return Column(
      spacing: 6.h,
      children: [
        ClipRRect(
          borderRadius: AppRadius.r12,
          child: Container(
            height: 96.h,
            width: double.infinity,
            alignment: Alignment.center,
            color: context.colors.brandPrimaryTint,
            child: photo == null
                ? AppSvgIcon(
                    Assets.vectorsIcImage20,
                    size: 24,
                    color: context.colors.textCaption,
                  )
                : AppNetworkImage(photo, height: 96.h),
          ),
        ),
        AppText(
          caption,
          style: context.typography.bodyXS,
          color: context.colors.textSubTitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
