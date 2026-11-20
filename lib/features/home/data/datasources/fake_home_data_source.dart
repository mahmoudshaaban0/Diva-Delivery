import 'package:geolocator/geolocator.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/network_info.dart';
import 'package:limitless_code_template/features/home/data/datasources/home_data_source.dart';
import 'package:limitless_code_template/features/home/data/models/announcement_model.dart';
import 'package:limitless_code_template/features/home/data/models/home_response_model.dart';
import 'package:limitless_code_template/features/home/data/models/start_day_response_model.dart';
import 'package:limitless_code_template/features/home/data/models/warehouse_model.dart';

/// Offline stand-in used while there is no backend (`BASE_URL` empty), with
/// the Figma sample data. See `HomeModule`.
///
/// - Every call checks the real connection first (offline → toast).
/// - "Start day" runs a real geofence check against [warehouse] (Riyadh).
///   On the iOS Simulator use Features → Location → Custom Location
///   (24.7136, 46.6753) to be inside; the default location is outside.
class FakeHomeDataSource implements HomeDataSource {
  FakeHomeDataSource(this.networkInfo);

  final NetworkInfo networkInfo;

  static const warehouse = WarehouseModel(
    name: 'مستودع الرياض الرئيسي',
    latitude: 24.7136,
    longitude: 46.6753,
  );
  static const _latency = Duration(milliseconds: 700);
  static const _ordersToday = 18;

  DateTime? _startedAt;

  @override
  Never get apiConsumer =>
      throw UnsupportedError('FakeHomeDataSource has no ApiConsumer');

  @override
  Future<HomeResponseModel> getHome() async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
    await Future<void>.delayed(_latency);
    return HomeResponseModel(
      courierName: 'خالد العتيبي',
      area: 'الرياض · حي عرقة',
      totalCollected: 8450,
      totalOrders: 126,
      cancelledOrders: 4,
      completedOrders: 104,
      pendingOrders: _ordersToday,
      deliveredToday: 0,
      assignedToday: _ordersToday,
      dayStartedAt: _startedAt,
      warehouse: warehouse,
      announcements: const [
        AnnouncementModel(
          title: 'سلّم طلبات الفروع قبل 4:00 م',
          body: 'تذكير من إدارة العمليات لهذا الأسبوع',
        ),
        AnnouncementModel(
          title: 'تحديث التطبيق',
          body: 'ميزات جديدة لإثبات التسليم',
        ),
        AnnouncementModel(
          title: 'التزم بارتداء الزي الرسمي',
          body: 'يسري ابتداءً من الأحد القادم',
        ),
      ],
    );
  }

  @override
  Future<StartDayResponseModel> startDay({
    required double latitude,
    required double longitude,
  }) async {
    if (!await networkInfo.isConnected) {
      throw const NoInternetConnectionException();
    }
    await Future<void>.delayed(_latency);
    final meters = Geolocator.distanceBetween(
      latitude,
      longitude,
      warehouse.latitude,
      warehouse.longitude,
    );
    if (meters > warehouse.radiusMeters) {
      throw OutOfWarehouseRangeException(distanceKm: meters / 1000);
    }
    final startedAt = _startedAt = DateTime.now();
    return StartDayResponseModel(
      startedAt: startedAt,
      ordersCount: _ordersToday,
    );
  }
}
