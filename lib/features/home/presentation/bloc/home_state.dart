import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/features/home/data/models/home_response_model.dart';
import 'package:limitless_code_template/features/home/data/models/start_day_response_model.dart';

/// Where the swipe-to-start flow is.
enum StartDayStage {
  idle,

  /// Reading the location and asking the server (Figma "جارٍ التحقق").
  checking,

  /// Refused: outside the warehouse geofence (Figma "خارج نطاق المستودع").
  outOfRange,

  /// Day started (Figma "بدء اليوم – تم بنجاح").
  started,

  /// Any other failure (no location, no connection, server error).
  failed,
}

class HomeState extends BaseState<HomeState> {
  const HomeState({
    super.status,
    super.errorMessage,
    this.home,
    this.isOffline = false,
    this.isInWarehouseRange,
    this.startDayStage = StartDayStage.idle,
    this.distanceKm,
    this.startResult,
    this.isLocationUnavailable = false,
  });

  final HomeResponseModel? home;

  /// The last failure was a missing connection (shown as a toast).
  final bool isOffline;

  /// Live geofence check for the range pill; null until known.
  final bool? isInWarehouseRange;

  final StartDayStage startDayStage;

  /// Distance from the warehouse when [StartDayStage.outOfRange].
  final double? distanceKm;
  final StartDayResponseModel? startResult;

  /// Start day failed because the position couldn't be read.
  final bool isLocationUnavailable;

  @override
  HomeState copyWith({
    AppStatus? status,
    String? errorMessage,
    HomeResponseModel? home,
    bool? isOffline,
    bool? isInWarehouseRange,
    StartDayStage? startDayStage,
    double? distanceKm,
    StartDayResponseModel? startResult,
    bool? isLocationUnavailable,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      home: home ?? this.home,
      isOffline: isOffline ?? this.isOffline,
      isInWarehouseRange: isInWarehouseRange ?? this.isInWarehouseRange,
      startDayStage: startDayStage ?? this.startDayStage,
      distanceKm: distanceKm ?? this.distanceKm,
      startResult: startResult ?? this.startResult,
      isLocationUnavailable:
          isLocationUnavailable ?? this.isLocationUnavailable,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    home,
    isOffline,
    isInWarehouseRange,
    startDayStage,
    distanceKm,
    startResult,
    isLocationUnavailable,
  ];
}
