import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/services/permission_service.dart';
import 'package:limitless_code_template/features/permissions/presentation/bloc/camera_permission_state.dart';

/// Success = done with this optional step (granted, refused or "Later").
/// Proof-of-delivery screens ask again when the camera is actually needed.
@injectable
class CameraPermissionCubit extends Cubit<CameraPermissionState> {
  CameraPermissionCubit(this._permissionService)
    : super(const CameraPermissionState());

  final PermissionService _permissionService;

  Future<void> request() async {
    if (state.status == AppStatus.loading) return;
    emit(state.copyWith(status: AppStatus.loading));
    await _permissionService.requestCameraAndPhotos();
    emit(state.copyWith(status: AppStatus.success));
  }

  void skip() => emit(state.copyWith(status: AppStatus.success));
}
