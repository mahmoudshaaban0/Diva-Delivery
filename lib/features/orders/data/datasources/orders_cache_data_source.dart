import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/storage/key_value_storage.dart';
import 'package:limitless_code_template/features/orders/data/models/orders_response_model.dart';

/// Keeps the last loaded orders on the device, so the lists still show
/// when the courier goes offline (Figma Flow 08 "بدون إنترنت – بيانات
/// محفوظة").
@lazySingleton
class OrdersCacheDataSource {
  OrdersCacheDataSource(this.storage);
  final KeyValueStorage storage;

  /// Saves [response] stamped with the current time.
  Future<void> save(OrdersScope scope, OrdersResponseModel response) {
    final stamped = OrdersResponseModel(
      orders: response.orders,
      cachedAt: DateTime.now(),
    );
    return storage.setString(
      'orders_cache_${scope.name}',
      jsonEncode(stamped.toJson()),
    );
  }

  /// The saved copy, or null when nothing was saved yet. Throws
  /// [FormatException] when the saved JSON is broken.
  OrdersResponseModel? read(OrdersScope scope) {
    final raw = storage.getString('orders_cache_${scope.name}');
    if (raw == null) return null;
    return OrdersResponseModel.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }
}
