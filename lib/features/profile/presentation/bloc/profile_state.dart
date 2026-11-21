import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/services/permission_service.dart';
import 'package:limitless_code_template/features/profile/data/models/profile_response_model.dart';

class ProfileState extends BaseState<ProfileState> {
  const ProfileState({
    super.status,
    super.errorMessage,
    this.profile,
    this.isOffline = false,
    this.locationAccess,
    this.photoStatus = AppStatus.initial,
    this.logoutStatus = AppStatus.initial,
  });

  final ProfileResponseModel? profile;

  /// The last failure was a missing connection (shown as a toast).
  final bool isOffline;

  /// Value of the "إذن الموقع" row; null until read.
  final LocationAccess? locationAccess;

  /// Uploading or deleting the photo (the avatar shimmers while loading).
  final AppStatus photoStatus;

  /// Logging out (spinner in the sheet; success goes to sign-in).
  final AppStatus logoutStatus;

  @override
  ProfileState copyWith({
    AppStatus? status,
    String? errorMessage,
    ProfileResponseModel? profile,
    bool? isOffline,
    LocationAccess? locationAccess,
    AppStatus? photoStatus,
    AppStatus? logoutStatus,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      profile: profile ?? this.profile,
      isOffline: isOffline ?? this.isOffline,
      locationAccess: locationAccess ?? this.locationAccess,
      photoStatus: photoStatus ?? this.photoStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    profile,
    isOffline,
    locationAccess,
    photoStatus,
    logoutStatus,
  ];
}
