import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/services/permission_service.dart';
import 'package:limitless_code_template/features/permissions/presentation/bloc/location_permission_state.dart';

/// Success = location granted, move on to the next step.
@injectable
class LocationPermissionCubit extends Cubit<LocationPermissionState> {
  LocationPermissionCubit(this._permissionService)
    : super(const LocationPermissionState());

  final PermissionService _permissionService;

  /// Called when the app comes back from the system settings. (Skipping the
  /// screen when already granted is done by the route's `redirect`.)
  Future<void> checkStatus() async {
    if (state.status == AppStatus.loading) return;
    if (await _permissionService.isLocationGranted()) {
      emit(state.copyWith(status: AppStatus.success, isDenied: false));
    }
  }

  /// Asks for "while using the app", then for "Allow all the time" (the
  /// screen's note). Only the first one is required to continue.
  Future<void> request() async {
    if (state.status == AppStatus.loading) return;
    emit(state.copyWith(status: AppStatus.loading));
    final granted = await _permissionService.requestLocation();
    if (granted) {
      await _permissionService.requestLocationAlways();
      emit(state.copyWith(status: AppStatus.success, isDenied: false));
    } else {
      emit(state.copyWith(status: AppStatus.failure, isDenied: true));
    }
  }

  Future<void> openSettings() => _permissionService.openSettings();
}
