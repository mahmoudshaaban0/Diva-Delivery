import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_tone_icon.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_card.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_details_model.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_product_row.dart';

/// "المنتجات (5)": the first [collapsedCount] products, with "عرض كل
/// المنتجات (5)" to show the rest.
class OrderDetailsProductsCard extends StatefulWidget {
  const OrderDetailsProductsCard({required this.products, super.key});

  final List<OrderProductModel> products;

  static const collapsedCount = 3;

  @override
  State<OrderDetailsProductsCard> createState() =>
      _OrderDetailsProductsCardState();
}

class _OrderDetailsProductsCardState extends State<OrderDetailsProductsCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final products = widget.products;
    final canExpand = products.length > OrderDetailsProductsCard.collapsedCount;
    final shown = _expanded || !canExpand
        ? products
        : products.take(OrderDetailsProductsCard.collapsedCount).toList();
    final divider = Divider(
      height: 1,
      thickness: 1,
      color: context.colors.surfaceLine,
    );

    return AppInfoCard(
      title: context.localizations.orderProducts(products.length),
      icon: const AppToneIcon(iconAsset: Assets.vectorsIcPackage16),
      rows: [
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          alignment: AlignmentDirectional.topStart,
          child: Column(
            spacing: 12.h,
            children: [
              for (final (index, product) in shown.indexed) ...[
                if (index > 0) divider,
                OrderProductRow(product: product),
              ],
            ],
          ),
        ),
        if (canExpand) ...[
          divider,
          Semantics(
            button: true,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _expanded = !_expanded),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4.w,
                children: [
                  AppText(
                    _expanded
                        ? context.localizations.showFewerProducts
                        : context.localizations.showAllProducts(
                            products.length,
                          ),
                    style: context.typography.subtitleS,
                    color: context.colors.brandPrimary,
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: AppSvgIcon(
                      Assets.vectorsIcArrowDown14,
                      size: 14,
                      color: context.colors.brandPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
