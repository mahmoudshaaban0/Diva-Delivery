import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens turn-by-turn directions in the device's maps app.
@lazySingleton
class DirectionsService {
  /// Apple Maps on iOS, Google Maps elsewhere (app if installed, else the
  /// browser). Returns false when nothing could open the link.
  Future<bool> openDirections({
    required double latitude,
    required double longitude,
  }) {
    final uri = defaultTargetPlatform == TargetPlatform.iOS
        ? Uri.https('maps.apple.com', '/', {'daddr': '$latitude,$longitude'})
        : Uri.https('www.google.com', '/maps/dir/', {
            'api': '1',
            'destination': '$latitude,$longitude',
          });
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
