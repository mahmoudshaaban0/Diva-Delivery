import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/core/networking/network_info.dart';
import 'package:limitless_code_template/features/home/data/datasources/fake_home_data_source.dart';
import 'package:limitless_code_template/features/home/data/datasources/home_data_source.dart';

@module
abstract class HomeModule {
  /// Uses the offline [FakeHomeDataSource] until a `BASE_URL` is configured.
  @lazySingleton
  HomeDataSource homeDataSource(
    ApiConsumer apiConsumer,
    NetworkInfo networkInfo,
  ) => Env.baseUrl.isEmpty
      ? FakeHomeDataSource(networkInfo)
      : HomeDataSource(apiConsumer);
}
