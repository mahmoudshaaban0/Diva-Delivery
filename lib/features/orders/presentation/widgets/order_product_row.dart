import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_network_image.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_price.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_details_model.dart';

/// One product line (Figma `Courier/Product Row`): thumbnail, name,
/// category and quantity, line total and unit price.
class OrderProductRow extends StatelessWidget {
  const OrderProductRow({required this.product, super.key});

  final OrderProductModel product;

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.imageUrl;

    return Row(
      spacing: 12.w,
      children: [
        ClipRRect(
          borderRadius: AppRadius.r12,
          child: Container(
            width: 48.r,
            height: 48.r,
            alignment: Alignment.center,
            color: context.colors.brandPrimaryTint,
            child: imageUrl == null
                ? AppSvgIcon(
                    Assets.vectorsIcPackage22,
                    size: 22,
                    color: context.colors.textTitle,
                  )
                : AppNetworkImage(imageUrl, width: 48.r, height: 48.r),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.h,
            children: [
              AppText(
                product.name,
                style: context.typography.subtitleS,
                color: context.colors.textTitle,
                maxLines: 1,
              ),
              AppText(
                context.localizations.productMeta(
                  product.category,
                  product.quantity,
                ),
                style: context.typography.bodyXS,
                color: context.colors.textSubTitle,
                maxLines: 1,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 2.h,
          children: [
            AppPrice(
              amount: product.total,
              showCents: true,
              style: context.typography.subtitleS,
            ),
            // "⃁ 18.00 للوحدة": the unit label follows the number.
            Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.ltr,
              spacing: 4.w,
              children: [
                AppPrice(
                  amount: product.unitPrice,
                  showCents: true,
                  style: context.typography.bodyXS,
                  color: context.colors.textCaption,
                ),
                AppText(
                  context.localizations.productUnitPrice,
                  style: context.typography.bodyXS,
                  color: context.colors.textCaption,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
