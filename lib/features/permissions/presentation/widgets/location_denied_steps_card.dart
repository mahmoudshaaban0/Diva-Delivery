import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_benefit_row.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_benefits_card.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// How to turn location on from settings (Figma "إذن الموقع · مرفوض").
class LocationDeniedStepsCard extends StatelessWidget {
  const LocationDeniedStepsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBenefitsCard(
      rows: [
        AppBenefitRow(
          iconAsset: Assets.vectorsIcSettings20,
          title: context.localizations.locationDeniedStepSettingsTitle,
          subtitle: context.localizations.locationDeniedStepSettingsSubtitle,
        ),
        AppBenefitRow(
          iconAsset: Assets.vectorsIcLocation20,
          title: context.localizations.locationDeniedStepAppTitle,
          subtitle: context.localizations.locationDeniedStepAppSubtitle,
        ),
        AppBenefitRow(
          iconAsset: Assets.vectorsIcClock20,
          title: context.localizations.locationDeniedStepAlwaysTitle,
          subtitle: context.localizations.locationDeniedStepAlwaysSubtitle,
        ),
      ],
    );
  }
}
