import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_asset_image.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_vector_image.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/formatters/amount_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_geofence_road.dart';

/// Simplified map of the warehouse zone and the courier's position (Figma
/// `Sheet Content/Geofence`). Decorative: laid out in Figma's 353×150
/// design units and scaled as one box, so every piece stays in place on any
/// width. Physical layout (not mirrored): the design draws it the same way
/// in both languages.
class HomeGeofenceMap extends StatelessWidget {
  const HomeGeofenceMap({required this.distanceKm, super.key});

  /// Shown in the chip; the chip is hidden when unknown.
  final double? distanceKm;

  static const double _width = 353;
  static const double _height = 150;

  @override
  Widget build(BuildContext context) {
    final distance = distanceKm;

    return ClipRRect(
      borderRadius: AppRadius.r20,
      child: ColoredBox(
        color: context.colors.brandPrimaryTint,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              width: _width,
              height: _height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const HomeGeofenceRoad(top: 75, angleDegrees: 8),
                  const HomeGeofenceRoad(top: 74, angleDegrees: -6),
                  Positioned(
                    left: 78,
                    top: 84.5,
                    child: Transform.rotate(
                      angle: -10 * math.pi / 180,
                      child: AppVectorImage(
                        Assets.vectorsGeofenceDistancePath,
                        width: 170,
                        height: 1.5,
                        color: context.colors.textSubTitle,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 210,
                    top: 18,
                    child: AppAssetImage(
                      Assets.rastersGeofenceWarehouseZone,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Positioned(
                    left: 252,
                    top: 60,
                    child: Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: context.colors.systemGreen,
                        shape: BoxShape.circle,
                      ),
                      child: AppSvgIcon(
                        Assets.vectorsIcLocation18,
                        size: 18,
                        color: context.colors.textAlwaysWhite,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 45,
                    top: 83,
                    child: AppVectorImage(
                      Assets.vectorsGeofenceYouHalo,
                      width: 44,
                      height: 44,
                    ),
                  ),
                  const Positioned(
                    left: 58,
                    top: 96,
                    child: AppVectorImage(
                      Assets.vectorsGeofenceYou,
                      width: 18,
                      height: 18,
                    ),
                  ),
                  if (distance != null)
                    Positioned(
                      left: 16,
                      top: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.surfaceCard,
                          borderRadius: AppRadius.rfull,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Directionality(
                          textDirection: Directionality.of(context),
                          child: AppText(
                            context.localizations.distanceFromWarehouse(
                              AmountFormatter.oneDecimal(distance),
                            ),
                            style: context.typography.subtitleXS,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: 0,
                    width: 123,
                    top: 128,
                    child: AppText(
                      context.localizations.youAreHere,
                      style: context.typography.body2XS,
                      color: context.colors.systemBlueText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
