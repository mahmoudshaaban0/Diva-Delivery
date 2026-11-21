import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/network_info.dart';
import 'package:limitless_code_template/features/profile/data/datasources/profile_data_source.dart';
import 'package:limitless_code_template/features/profile/data/models/profile_response_model.dart';

/// Offline stand-in used while there is no backend (`BASE_URL` empty), with
/// the Figma sample data. See `ProfileModule`.
///
/// - Every call checks the real connection first (offline → toast).
/// - The courier has 3 open orders, so logging out shows the "open orders"
///   warning; set [_openOrders] to 0 to see the plain confirmation.
/// - An "uploaded" photo is kept as its local file path for the session.
class FakeProfileDataSource implements ProfileDataSource {
  FakeProfileDataSource(this.networkInfo);

  final NetworkInfo networkInfo;

  static const _latency = Duration(milliseconds: 700);
  static const _openOrders = 3;

  String? _photoPath;

  @override
  Never get apiConsumer =>
      throw UnsupportedError('FakeProfileDataSource has no ApiConsumer');

  @override
  Future<ProfileResponseModel> getProfile() async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
    await Future<void>.delayed(_latency);
    return ProfileResponseModel(
      name: 'خالد العتيبي',
      code: 'DRV-0142',
      phone: '551234567',
      email: 'khalid@expertpartners.sa',
      photoUrl: _photoPath,
      isOnDuty: true,
      warehouse: 'مستودع الرياض الرئيسي',
      supervisor: 'خالد الشهري',
      vehicle: 'هايلكس · ر ج ب 4821',
      joinedAt: DateTime(2025, 3),
      openOrders: _openOrders,
    );
  }

  @override
  Future<String> updatePhoto(String imagePath) async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
    await Future<void>.delayed(_latency);
    return _photoPath = imagePath;
  }

  @override
  Future<void> deletePhoto() async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
    await Future<void>.delayed(_latency);
    _photoPath = null;
  }

  @override
  Future<void> logout() async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
    await Future<void>.delayed(_latency);
  }
}
