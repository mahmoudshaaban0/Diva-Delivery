import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/core/networking/network_info.dart';
import 'package:limitless_code_template/features/profile/data/datasources/fake_profile_data_source.dart';
import 'package:limitless_code_template/features/profile/data/datasources/profile_data_source.dart';

@module
abstract class ProfileModule {
  /// Uses the offline [FakeProfileDataSource] until a `BASE_URL` is
  /// configured.
  @lazySingleton
  ProfileDataSource profileDataSource(
    ApiConsumer apiConsumer,
    NetworkInfo networkInfo,
  ) => Env.baseUrl.isEmpty
      ? FakeProfileDataSource(networkInfo)
      : ProfileDataSource(apiConsumer);
}
