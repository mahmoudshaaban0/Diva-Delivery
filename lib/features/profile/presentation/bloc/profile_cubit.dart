import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/core/services/image_picker_service.dart';
import 'package:limitless_code_template/core/services/permission_service.dart';
import 'package:limitless_code_template/features/profile/data/models/profile_response_model.dart';
import 'package:limitless_code_template/features/profile/data/repositories/profile_repository.dart';
import 'package:limitless_code_template/features/profile/presentation/bloc/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._profileRepository,
    this._permissionService,
    this._imagePickerService,
  ) : super(const ProfileState());

  final ProfileRepository _profileRepository;
  final PermissionService _permissionService;
  final ImagePickerService _imagePickerService;

  /// Loads the profile and the location permission level.
  Future<void> getProfile() async {
    emit(state.copyWith(status: AppStatus.loading, isOffline: false));
    final access = _permissionService.locationAccess();
    final result = await _profileRepository.getProfile();
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            status: AppStatus.success,
            profile: data,
            locationAccess: await access,
          ),
        );
      case Error(:final exception):
        emit(
          state.copyWith(
            status: AppStatus.failure,
            isOffline: exception is NoInternetConnectionException,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }

  /// Shows a profile that's already loaded (opening "المعلومات الشخصية" from
  /// the profile tab), without fetching it again.
  void showProfile(ProfileResponseModel profile) {
    emit(state.copyWith(status: AppStatus.success, profile: profile));
  }

  /// Re-reads the location permission (after returning from the settings).
  Future<void> refreshLocationAccess() async {
    final access = await _permissionService.locationAccess();
    if (!isClosed) emit(state.copyWith(locationAccess: access));
  }

  Future<void> openLocationSettings() => _permissionService.openSettings();

  /// Takes or picks a photo, then uploads it. Cancelling does nothing.
  Future<void> changePhoto(ImagePickSource source) async {
    final profile = state.profile;
    if (profile == null || state.photoStatus == AppStatus.loading) return;
    final path = await _imagePickerService.pick(source);
    if (path == null) return;

    emit(state.copyWith(photoStatus: AppStatus.loading, isOffline: false));
    final result = await _profileRepository.updatePhoto(path);
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            photoStatus: AppStatus.success,
            profile: profile.withPhoto(data),
          ),
        );
      case Error(:final exception):
        emit(
          state.copyWith(
            photoStatus: AppStatus.failure,
            isOffline: exception is NoInternetConnectionException,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }

  Future<void> deletePhoto() async {
    final profile = state.profile;
    if (profile == null || state.photoStatus == AppStatus.loading) return;

    emit(state.copyWith(photoStatus: AppStatus.loading, isOffline: false));
    final result = await _profileRepository.deletePhoto();
    switch (result) {
      case Success():
        emit(
          state.copyWith(
            photoStatus: AppStatus.success,
            profile: profile.withPhoto(null),
          ),
        );
      case Error(:final exception):
        emit(
          state.copyWith(
            photoStatus: AppStatus.failure,
            isOffline: exception is NoInternetConnectionException,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }

  /// NOTE: once sessions are stored, also clear the saved token here.
  Future<void> logout() async {
    if (state.logoutStatus == AppStatus.loading) return;
    emit(state.copyWith(logoutStatus: AppStatus.loading, isOffline: false));
    final result = await _profileRepository.logout();
    switch (result) {
      case Success():
        emit(state.copyWith(logoutStatus: AppStatus.success));
      case Error(:final exception):
        emit(
          state.copyWith(
            logoutStatus: AppStatus.failure,
            isOffline: exception is NoInternetConnectionException,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }
}
