import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_benefit_row.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_benefits_card.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Why the app needs the camera and photos (Figma "إذن الكاميرا والصور").
class CameraBenefitsCard extends StatelessWidget {
  const CameraBenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBenefitsCard(
      rows: [
        AppBenefitRow(
          iconAsset: Assets.vectorsIcCamera20,
          title: context.localizations.cameraBenefitProofTitle,
          subtitle: context.localizations.cameraBenefitProofSubtitle,
        ),
        AppBenefitRow(
          iconAsset: Assets.vectorsIcImage20,
          title: context.localizations.cameraBenefitCallLogTitle,
          subtitle: context.localizations.cameraBenefitCallLogSubtitle,
        ),
      ],
    );
  }
}
