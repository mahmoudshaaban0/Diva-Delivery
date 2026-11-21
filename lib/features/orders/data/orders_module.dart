import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/core/networking/network_info.dart';
import 'package:limitless_code_template/features/orders/data/datasources/fake_orders_data_source.dart';
import 'package:limitless_code_template/features/orders/data/datasources/orders_data_source.dart';

@module
abstract class OrdersModule {
  /// Uses the offline [FakeOrdersDataSource] until a `BASE_URL` is
  /// configured.
  @lazySingleton
  OrdersDataSource ordersDataSource(
    ApiConsumer apiConsumer,
    NetworkInfo networkInfo,
  ) => Env.baseUrl.isEmpty
      ? FakeOrdersDataSource(networkInfo)
      : OrdersDataSource(apiConsumer);
}
