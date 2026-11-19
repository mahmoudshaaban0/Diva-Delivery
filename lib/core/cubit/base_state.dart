import 'package:equatable/equatable.dart';

enum AppStatus { initial, loading, success, failure }

abstract class BaseState<T> extends Equatable {
  const BaseState({this.status = AppStatus.initial, this.errorMessage});

  final AppStatus status;
  final String? errorMessage;

  T copyWith({AppStatus? status, String? errorMessage});

  @override
  List<Object?> get props => [status, errorMessage];
}
