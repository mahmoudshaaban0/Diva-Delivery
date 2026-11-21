import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/network_info.dart';
import 'package:limitless_code_template/features/orders/data/datasources/orders_data_source.dart';
import 'package:limitless_code_template/features/orders/data/models/order_details_model.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';
import 'package:limitless_code_template/features/orders/data/models/orders_response_model.dart';

/// Offline stand-in used while there is no backend (`BASE_URL` empty), with
/// the Figma sample orders. See `OrdersModule`.
///
/// - Every call checks the real connection first (offline → toast).
/// - Set [_hasCurrentOrders] to false to see "أنهيت طلبات اليوم".
/// - Every order opens the same 5 products (Figma `#ORD-10234`); the
///   subtotal follows the order's own total.
class FakeOrdersDataSource implements OrdersDataSource {
  FakeOrdersDataSource(this.networkInfo);

  final NetworkInfo networkInfo;

  static const _latency = Duration(milliseconds: 700);
  static const _hasCurrentOrders = true;
  static const _deliveryFee = 15.0;

  @override
  Never get apiConsumer =>
      throw UnsupportedError('FakeOrdersDataSource has no ApiConsumer');

  static DateTime _today(int hour, int minute) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  static DateTime _daysAgo(int days, int hour, int minute) =>
      _today(hour, minute).subtract(Duration(days: days));

  static List<OrderModel> get _current => [
    OrderModel(
      id: '10234',
      code: 'ORD-10234',
      customerName: 'أحمد العتيبي',
      customerType: CustomerType.individual,
      phone: '501234567',
      district: 'حي العليا',
      city: 'الرياض',
      latitude: 24.6905,
      longitude: 46.6853,
      distanceKm: 1.2,
      status: OrderStatus.onTheWay,
      assignedAt: _today(8, 30),
      itemsCount: 5,
      total: 345,
      paymentMethod: PaymentMethod.cashOnDelivery,
    ),
    OrderModel(
      id: '10241',
      code: 'ORD-10241',
      customerName: 'مطعم ورق العنب',
      customerType: CustomerType.business,
      phone: '512345678',
      district: 'حي الملقا',
      city: 'الرياض',
      latitude: 24.8104,
      longitude: 46.6105,
      distanceKm: 3.2,
      status: OrderStatus.withCourier,
      assignedAt: _today(8, 30),
      itemsCount: 12,
      total: 1280,
      paymentMethod: PaymentMethod.prepaid,
      isPaid: true,
    ),
    OrderModel(
      id: '10247',
      code: 'ORD-10247',
      customerName: 'سارة القحطاني',
      customerType: CustomerType.individual,
      phone: '523456789',
      district: 'حي النرجس',
      city: 'الرياض',
      latitude: 24.8396,
      longitude: 46.6603,
      distanceKm: 4.8,
      status: OrderStatus.withCourier,
      assignedAt: _today(8, 35),
      itemsCount: 2,
      total: 189.5,
      paymentMethod: PaymentMethod.cashOnDelivery,
    ),
    OrderModel(
      id: '10252',
      code: 'ORD-10252',
      customerName: 'صيدلية الدواء',
      customerType: CustomerType.business,
      phone: '534567890',
      district: 'حي الياسمين',
      city: 'الرياض',
      latitude: 24.8231,
      longitude: 46.6417,
      distanceKm: 6.1,
      status: OrderStatus.withCourier,
      assignedAt: _today(8, 40),
      itemsCount: 6,
      total: 560,
      paymentMethod: PaymentMethod.prepaid,
      isPaid: true,
    ),
    OrderModel(
      id: '10258',
      code: 'ORD-10258',
      customerName: 'عبدالله الحربي',
      customerType: CustomerType.individual,
      phone: '545678901',
      district: 'حي الربوة',
      city: 'الرياض',
      latitude: 24.6829,
      longitude: 46.7577,
      distanceKm: 7.4,
      status: OrderStatus.withCourier,
      assignedAt: _today(9, 10),
      itemsCount: 1,
      total: 98,
      paymentMethod: PaymentMethod.cashOnDelivery,
    ),
  ];

  static List<OrderModel> get _previous => [
    OrderModel(
      id: '10198',
      code: 'ORD-10198',
      customerName: 'خالد الشهري',
      customerType: CustomerType.individual,
      phone: '556789012',
      district: 'حي الربيع',
      city: 'الرياض',
      latitude: 24.7951,
      longitude: 46.6563,
      status: OrderStatus.delivered,
      assignedAt: _daysAgo(1, 9, 0),
      closedAt: _daysAgo(1, 14, 15),
      itemsCount: 2,
      total: 220,
      paymentMethod: PaymentMethod.cashOnDelivery,
      isPaid: true,
    ),
    OrderModel(
      id: '10201',
      code: 'ORD-10201',
      customerName: 'مقهى نخلة',
      customerType: CustomerType.business,
      phone: '567890123',
      district: 'حي الصحافة',
      city: 'الرياض',
      latitude: 24.8106,
      longitude: 46.6390,
      status: OrderStatus.noAnswer,
      assignedAt: _daysAgo(1, 9, 0),
      closedAt: _daysAgo(1, 16, 40),
      itemsCount: 5,
      total: 430,
      paymentMethod: PaymentMethod.cashOnDelivery,
    ),
    OrderModel(
      id: '10205',
      code: 'ORD-10205',
      customerName: 'نورة الدوسري',
      customerType: CustomerType.individual,
      phone: '578901234',
      district: 'حي القيروان',
      city: 'الرياض',
      latitude: 24.8350,
      longitude: 46.5900,
      status: OrderStatus.rejected,
      assignedAt: _daysAgo(1, 9, 0),
      closedAt: _daysAgo(1, 17, 10),
      itemsCount: 1,
      total: 95,
      paymentMethod: PaymentMethod.cashOnDelivery,
    ),
    OrderModel(
      id: '10176',
      code: 'ORD-10176',
      customerName: 'فهد المطيري',
      customerType: CustomerType.individual,
      phone: '589012345',
      district: 'حي الوادي',
      city: 'الرياض',
      latitude: 24.7880,
      longitude: 46.6800,
      status: OrderStatus.delivered,
      assignedAt: _daysAgo(2, 8, 30),
      closedAt: _daysAgo(2, 11, 5),
      itemsCount: 4,
      total: 310,
      paymentMethod: PaymentMethod.prepaid,
      isPaid: true,
    ),
  ];

  static const _products = [
    OrderProductModel(
      name: 'مياه نوفا 330 مل',
      category: 'مشروبات',
      quantity: 2,
      unitPrice: 18,
    ),
    OrderProductModel(
      name: 'أرز بسمتي 5 كجم',
      category: 'مواد غذائية',
      quantity: 1,
      unitPrice: 62,
    ),
    OrderProductModel(
      name: 'زيت زيتون 1 لتر',
      category: 'زيوت',
      quantity: 4,
      unitPrice: 43,
    ),
    OrderProductModel(
      name: 'تمر سكري 1 كجم',
      category: 'تمور',
      quantity: 1,
      unitPrice: 35,
    ),
    OrderProductModel(
      name: 'حليب طويل الأجل 1 لتر',
      category: 'ألبان',
      quantity: 5,
      unitPrice: 5,
    ),
  ];

  @override
  Future<OrdersResponseModel> getOrders(OrdersScope scope) async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
    await Future<void>.delayed(_latency);
    return OrdersResponseModel(
      orders: switch (scope) {
        OrdersScope.current => _hasCurrentOrders ? _current : const [],
        OrdersScope.previous => _previous,
      },
    );
  }

  @override
  Future<OrderDetailsModel> getOrderDetails(String id) async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
    await Future<void>.delayed(_latency);
    final order = [..._current, ..._previous].firstWhere(
      (order) => order.id == id,
      orElse: () => throw const NotFoundException(),
    );
    return OrderDetailsModel(
      order: order,
      products: _products,
      subtotal: order.total - _deliveryFee,
      deliveryFee: _deliveryFee,
      nationalAddress: 'RRRD2929',
    );
  }
}
