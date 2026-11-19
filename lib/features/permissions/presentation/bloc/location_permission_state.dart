import 'package:limitless_code_template/core/cubit/base_state.dart';

class LocationPermissionState extends BaseState<LocationPermissionState> {
  const LocationPermissionState({
    super.status,
    super.errorMessage,
    this.isDenied = false,
  });

  /// The user refused location (Figma "إذن الموقع · مرفوض").
  final bool isDenied;

  @override
  LocationPermissionState copyWith({
    AppStatus? status,
    String? errorMessage,
    bool? isDenied,
  }) {
    return LocationPermissionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isDenied: isDenied ?? this.isDenied,
    );
  }

  @override
  List<Object?> get props => [...super.props, isDenied];
}
