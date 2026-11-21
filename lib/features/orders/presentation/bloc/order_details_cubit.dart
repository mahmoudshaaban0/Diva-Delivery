import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/formatters/phone_formatter.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/core/services/call_service.dart';
import 'package:limitless_code_template/core/services/directions_service.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';
import 'package:limitless_code_template/features/orders/data/repositories/orders_repository.dart';
import 'package:limitless_code_template/features/orders/presentation/bloc/order_details_state.dart';

@injectable
class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(
    this._ordersRepository,
    this._callService,
    this._directionsService,
  ) : super(const OrderDetailsState());

  final OrdersRepository _ordersRepository;
  final CallService _callService;
  final DirectionsService _directionsService;

  Future<void> getDetails(String id) async {
    emit(state.copyWith(status: AppStatus.loading, isOffline: false));
    final result = await _ordersRepository.getOrderDetails(id);
    switch (result) {
      case Success(:final data):
        emit(state.copyWith(status: AppStatus.success, details: data));
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

  /// Returns false when no app could place the call.
  Future<bool> callCustomer(OrderModel order) =>
      _callService.call(PhoneFormatter.saudiDisplay(order.phone));

  /// "الذهاب للعميل" / "فتح الخريطة". False when nothing could open it.
  Future<bool> navigateTo(OrderModel order) => _directionsService
      .openDirections(latitude: order.latitude, longitude: order.longitude);
}
