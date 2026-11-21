import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/formatters/phone_formatter.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/core/services/call_service.dart';
import 'package:limitless_code_template/core/services/directions_service.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';
import 'package:limitless_code_template/features/orders/data/models/orders_response_model.dart';
import 'package:limitless_code_template/features/orders/data/repositories/orders_repository.dart';
import 'package:limitless_code_template/features/orders/presentation/bloc/orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(
    this._ordersRepository,
    this._callService,
    this._directionsService,
  ) : super(const OrdersState());

  final OrdersRepository _ordersRepository;
  final CallService _callService;
  final DirectionsService _directionsService;

  /// Loads both tabs at once, so switching tabs is instant.
  Future<void> load() async {
    await Future.wait([getCurrentOrders(), getPreviousOrders()]);
  }

  Future<void> getCurrentOrders() async {
    emit(state.copyWith(status: AppStatus.loading, isOffline: false));
    final result = await _ordersRepository.getOrders(OrdersScope.current);
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(status: AppStatus.success, currentOrders: data.orders),
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

  Future<void> getPreviousOrders() async {
    emit(state.copyWith(previousStatus: AppStatus.loading, isOffline: false));
    final result = await _ordersRepository.getOrders(OrdersScope.previous);
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            previousStatus: AppStatus.success,
            previousOrders: data.orders,
          ),
        );
      case Error(:final exception):
        emit(
          state.copyWith(
            previousStatus: AppStatus.failure,
            isOffline: exception is NoInternetConnectionException,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }

  void selectTab(OrdersScope tab) => emit(state.copyWith(tab: tab));

  void search(String query) => emit(state.copyWith(query: query));

  void sortBy(OrdersSort sort) => emit(state.copyWith(sort: sort));

  /// Returns false when no app could place the call.
  Future<bool> callCustomer(OrderModel order) =>
      _callService.call(PhoneFormatter.saudiDisplay(order.phone));

  /// "متابعة الملاحة": opens the maps app. False when nothing could open it.
  Future<bool> navigateTo(OrderModel order) => _directionsService
      .openDirections(latitude: order.latitude, longitude: order.longitude);
}
