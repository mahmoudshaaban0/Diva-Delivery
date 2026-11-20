import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

/// Device location, wrapped around `geolocator` so cubits can be tested
/// with a fake. Permission is requested during onboarding
/// (`PermissionService`), so this only reads the position.
@lazySingleton
class LocationService {
  /// Current position, or null when location is off, denied, or times out.
  Future<({double latitude, double longitude})?> currentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          timeLimit: Duration(seconds: 15),
        ),
      );
      return (latitude: position.latitude, longitude: position.longitude);
    } on Exception {
      return null;
    }
  }

  /// Straight-line distance in meters between two points.
  double distanceInMeters({
    required double fromLatitude,
    required double fromLongitude,
    required double toLatitude,
    required double toLongitude,
  }) => Geolocator.distanceBetween(
    fromLatitude,
    fromLongitude,
    toLatitude,
    toLongitude,
  );
}
