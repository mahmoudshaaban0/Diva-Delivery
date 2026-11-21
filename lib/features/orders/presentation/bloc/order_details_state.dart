import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/features/orders/data/models/order_details_model.dart';

class OrderDetailsState extends BaseState<OrderDetailsState> {
  const OrderDetailsState({
    super.status,
    super.errorMessage,
    this.details,
    this.isOffline = false,
  });

  final OrderDetailsModel? details;

  /// The last failure was a missing connection.
  final bool isOffline;

  @override
  OrderDetailsState copyWith({
    AppStatus? status,
    String? errorMessage,
    OrderDetailsModel? details,
    bool? isOffline,
  }) {
    return OrderDetailsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      details: details ?? this.details,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [...super.props, details, isOffline];
}
