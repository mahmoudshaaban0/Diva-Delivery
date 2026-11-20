/// The warehouse the courier starts the day from, with its geofence.
///
/// Assumed payload:
/// `{"name": "...", "latitude": 24.71, "longitude": 46.67, "radius_m": 300}`.
class WarehouseModel {
  const WarehouseModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.radiusMeters = defaultRadiusMeters,
  });

  WarehouseModel.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String? ?? '',
      latitude = (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude = (json['longitude'] as num?)?.toDouble() ?? 0,
      radiusMeters =
          (json['radius_m'] as num?)?.toDouble() ?? defaultRadiusMeters;

  static const double defaultRadiusMeters = 300;

  final String name;
  final double latitude;
  final double longitude;

  /// Geofence radius around the warehouse.
  final double radiusMeters;

  Map<String, dynamic> toJson() => {
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
    'radius_m': radiusMeters,
  };
}
