import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/core/services/directions_service.dart';
import 'package:limitless_code_template/core/services/location_service.dart';
import 'package:limitless_code_template/features/home/data/repositories/home_repository.dart';
import 'package:limitless_code_template/features/home/presentation/bloc/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._homeRepository,
    this._locationService,
    this._directionsService,
  ) : super(const HomeState());

  final HomeRepository _homeRepository;
  final LocationService _locationService;
  final DirectionsService _directionsService;

  /// Loads the summary, then checks the live position against the warehouse
  /// geofence for the range pill (the server re-checks on start).
  Future<void> getHome() async {
    emit(state.copyWith(status: AppStatus.loading, isOffline: false));
    final result = await _homeRepository.getHome();
    switch (result) {
      case Success(:final data):
        emit(state.copyWith(status: AppStatus.success, home: data));
        final position = await _locationService.currentPosition();
        if (position == null || isClosed) return;
        final meters = _locationService.distanceInMeters(
          fromLatitude: position.latitude,
          fromLongitude: position.longitude,
          toLatitude: data.warehouse.latitude,
          toLongitude: data.warehouse.longitude,
        );
        emit(
          state.copyWith(
            isInWarehouseRange: meters <= data.warehouse.radiusMeters,
          ),
        );
      case Error(:final exception):
        emit(
          state.copyWith(
            status: AppStatus.failure,
            isOffline: exception is NoInternetConnectionException,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }

  /// Swipe-to-start: reads the position and asks the server to start the
  /// day. Ends in `started`, `outOfRange` or `failed` (see [StartDayStage]).
  Future<void> startDay() async {
    if (state.startDayStage == StartDayStage.checking) return;
    emit(
      state.copyWith(
        startDayStage: StartDayStage.checking,
        isOffline: false,
        isLocationUnavailable: false,
      ),
    );

    final position = await _locationService.currentPosition();
    if (position == null) {
      emit(
        state.copyWith(
          startDayStage: StartDayStage.failed,
          isLocationUnavailable: true,
        ),
      );
      return;
    }

    final result = await _homeRepository.startDay(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            startDayStage: StartDayStage.started,
            startResult: data,
            isInWarehouseRange: true,
          ),
        );
        // Refresh the summary so the home switches to "day started".
        final home = await _homeRepository.getHome();
        switch (home) {
          case Success(:final data):
            emit(state.copyWith(home: data));
          case Error():
            break;
        }
      case Error(:final exception):
        if (exception is OutOfWarehouseRangeException) {
          emit(
            state.copyWith(
              startDayStage: StartDayStage.outOfRange,
              distanceKm: exception.distanceKm,
              isInWarehouseRange: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              startDayStage: StartDayStage.failed,
              isOffline: exception is NoInternetConnectionException,
              errorMessage: exception is ServerException
                  ? exception.message
                  : exception.toString(),
            ),
          );
        }
    }
  }

  /// Called when a start-day sheet or toast is done, so the swipe resets.
  void resetStartDay() =>
      emit(state.copyWith(startDayStage: StartDayStage.idle));

  Future<void> openDirectionsToWarehouse() async {
    final warehouse = state.home?.warehouse;
    if (warehouse == null) return;
    await _directionsService.openDirections(
      latitude: warehouse.latitude,
      longitude: warehouse.longitude,
    );
  }
}
