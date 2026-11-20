import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_status_sheet.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_geofence_map.dart';

/// "You're outside the warehouse zone" sheet with the geofence map (Figma
/// "خارج نطاق المستودع").
class HomeOutOfRangeSheet extends StatelessWidget {
  const HomeOutOfRangeSheet({
    required this.warehouseName,
    required this.distanceKm,
    required this.onOpenDirections,
    required this.onTryAgain,
    super.key,
  });

  final String warehouseName;
  final double? distanceKm;
  final VoidCallback onOpenDirections;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    return AppStatusSheet(
      iconAsset: Assets.vectorsIcLocation26,
      tone: AppIconBadgeTone.warning,
      title: context.localizations.outOfRangeTitle,
      subtitle: context.localizations.outOfRangeSubtitle(warehouseName),
      content: HomeGeofenceMap(distanceKm: distanceKm),
      primaryLabel: context.localizations.openDirections,
      onPrimary: onOpenDirections,
      secondaryLabel: context.localizations.tryAgain,
      onSecondary: onTryAgain,
    );
  }
}
