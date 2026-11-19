import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/features/auth/data/repositories/auth_repository.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authRepository)
    : super(const ForgotPasswordState());

  final AuthRepository _authRepository;

  Timer? _timer;

  Future<void> sendLink(String email) async {
    if (state.status == AppStatus.loading) return;
    emit(state.copyWith(status: AppStatus.loading, isOffline: false));
    final result = await _authRepository.sendPasswordResetLink(email: email);
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            status: AppStatus.success,
            isLinkSent: true,
            email: email,
            validForMinutes: data.validForMinutes,
          ),
        );
        _startCountdown(data.resendAfterSeconds);
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

  Future<void> resend() async {
    if (!state.canResend) return;
    emit(
      state.copyWith(
        status: AppStatus.loading,
        isResending: true,
        isOffline: false,
      ),
    );
    final result = await _authRepository.sendPasswordResetLink(
      email: state.email,
    );
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            status: AppStatus.success,
            isResending: false,
            validForMinutes: data.validForMinutes,
          ),
        );
        _startCountdown(data.resendAfterSeconds);
      case Error(:final exception):
        emit(
          state.copyWith(
            status: AppStatus.failure,
            isResending: false,
            isOffline: exception is NoInternetConnectionException,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }

  void _startCountdown(int seconds) {
    _timer?.cancel();
    emit(state.copyWith(secondsLeft: seconds));
    if (seconds <= 0) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final next = state.secondsLeft - 1;
      emit(state.copyWith(secondsLeft: next));
      if (next <= 0) timer.cancel();
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
