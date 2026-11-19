import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_benefit_row.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_benefits_card.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Why the app needs location (Figma "إذن الموقع" · Benefits).
class LocationBenefitsCard extends StatelessWidget {
  const LocationBenefitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBenefitsCard(
      rows: [
        AppBenefitRow(
          iconAsset: Assets.vectorsIcLocation20,
          title: context.localizations.locationBenefitWarehouseTitle,
          subtitle: context.localizations.locationBenefitWarehouseSubtitle,
        ),
        AppBenefitRow(
          iconAsset: Assets.vectorsIcDeliveryBox20,
          title: context.localizations.locationBenefitRouteTitle,
          subtitle: context.localizations.locationBenefitRouteSubtitle,
        ),
        AppBenefitRow(
          iconAsset: Assets.vectorsIcClock20,
          title: context.localizations.locationBenefitTrackingTitle,
          subtitle: context.localizations.locationBenefitTrackingSubtitle,
        ),
      ],
    );
  }
}
