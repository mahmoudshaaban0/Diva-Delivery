import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

/// Device permissions the courier app needs, wrapped around
/// `permission_handler` so cubits can be tested with a fake.
@lazySingleton
class PermissionService {
  /// "While using the app" location, needed to start the day.
  Future<bool> isLocationGranted() async =>
      (await Permission.locationWhenInUse.status).isGranted;

  /// Asks for "while using the app" location. Returns true when granted.
  Future<bool> requestLocation() async =>
      (await Permission.locationWhenInUse.request()).isGranted;

  /// Asks for "Allow all the time" (tracking while the screen is locked).
  /// Only valid after [requestLocation] was granted; on Android 11+ the
  /// system sends the user to the app's location settings page.
  Future<bool> requestLocationAlways() async =>
      (await Permission.locationAlways.request()).isGranted;

  /// Camera and photo library (proof of delivery, call-log screenshots).
  Future<bool> isCameraAndPhotosGranted() async {
    final camera = await Permission.camera.status;
    final photos = await Permission.photos.status;
    return camera.isGranted && (photos.isGranted || photos.isLimited);
  }

  Future<void> requestCameraAndPhotos() async {
    await [Permission.camera, Permission.photos].request();
  }

  /// Opens this app's page in the system settings.
  Future<bool> openSettings() => openAppSettings();
}
