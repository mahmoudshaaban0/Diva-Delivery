import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_tone_icon.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_card.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_details_model.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_proof_photo.dart';

/// "إثبات التسليم" (delivered orders): the home and order photos taken at
/// delivery.
class OrderDetailsProofCard extends StatelessWidget {
  const OrderDetailsProofCard({required this.details, super.key});

  final OrderDetailsModel details;

  @override
  Widget build(BuildContext context) {
    return AppInfoCard(
      title: context.localizations.proofOfDelivery,
      icon: const AppToneIcon(
        iconAsset: Assets.vectorsIcImage16,
        tone: AppTone.green,
      ),
      rows: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.w,
          children: [
            Expanded(
              child: OrderProofPhoto(
                url: details.homePhotoUrl,
                caption: context.localizations.proofHomePhoto,
              ),
            ),
            Expanded(
              child: OrderProofPhoto(
                url: details.orderPhotoUrl,
                caption: context.localizations.proofOrderPhoto,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
