import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/features/auth/data/datasources/auth_data_source.dart';
import 'package:limitless_code_template/features/auth/data/datasources/fake_auth_data_source.dart';

@module
abstract class AuthModule {
  /// Uses the offline [FakeAuthDataSource] until a `BASE_URL` is configured
  /// (`--dart-define-from-file=env/<flavor>.json`).
  @lazySingleton
  AuthDataSource authDataSource(ApiConsumer apiConsumer) =>
      Env.baseUrl.isEmpty ? FakeAuthDataSource() : AuthDataSource(apiConsumer);
}
