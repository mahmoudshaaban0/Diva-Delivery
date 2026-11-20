import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_geofence_map.dart'
    show HomeGeofenceMap;

/// A wide pale road band crossing [HomeGeofenceMap].
class HomeGeofenceRoad extends StatelessWidget {
  const HomeGeofenceRoad({
    required this.top,
    required this.angleDegrees,
    super.key,
  });

  /// Vertical center of the band, in map design units.
  final double top;
  final double angleDegrees;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -74,
      top: top - 5,
      child: Transform.rotate(
        angle: angleDegrees * math.pi / 180,
        child: Container(
          width: 500,
          height: 10,
          color: context.colors.surfaceCard,
        ),
      ),
    );
  }
}
