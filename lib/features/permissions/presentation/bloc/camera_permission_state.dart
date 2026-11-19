import 'package:limitless_code_template/core/cubit/base_state.dart';

class CameraPermissionState extends BaseState<CameraPermissionState> {
  const CameraPermissionState({super.status, super.errorMessage});

  @override
  CameraPermissionState copyWith({AppStatus? status, String? errorMessage}) {
    return CameraPermissionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
