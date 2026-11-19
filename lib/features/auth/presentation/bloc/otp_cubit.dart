import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/features/auth/data/models/otp_sent_model.dart';
import 'package:limitless_code_template/features/auth/data/repositories/auth_repository.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/otp_state.dart';

@injectable
class OtpCubit extends Cubit<OtpState> {
  OtpCubit(
    this._authRepository,
    @factoryParam this.phone,
    @factoryParam int? resendAfterSeconds,
  ) : super(const OtpState()) {
    _startCountdown(resendAfterSeconds ?? OtpSentModel.defaultResendAfter);
  }

  final AuthRepository _authRepository;

  /// 9-digit national number the code was sent to.
  final String phone;

  static const int codeLength = 4;

  Timer? _timer;

  Future<void> verify(String code) async {
    if (code.length != codeLength || state.status == AppStatus.loading) {
      return;
    }
    emit(state.copyWith(status: AppStatus.loading));
    final result = await _authRepository.verifyOtp(phone: phone, code: code);
    switch (result) {
      case Success():
        // NOTE: persist the session token here once auth storage exists.
        emit(state.copyWith(status: AppStatus.success, isCodeInvalid: false));
      case Error(:final exception):
        emit(
          state.copyWith(
            status: AppStatus.failure,
            isCodeInvalid: exception is InvalidOtpException,
            attemptsLeft: exception is InvalidOtpException
                ? exception.attemptsLeft
                : null,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }

  /// Leaves the error state as soon as the user edits the code.
  void codeChanged() {
    if (state.status == AppStatus.failure) {
      emit(state.copyWith(status: AppStatus.initial, isCodeInvalid: false));
    }
  }

  Future<void> resend() async {
    if (!state.canResend) return;
    emit(state.copyWith(isResending: true));
    final result = await _authRepository.sendOtp(phone: phone);
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            status: AppStatus.initial,
            isResending: false,
            isCodeInvalid: false,
          ),
        );
        _startCountdown(data.resendAfterSeconds);
      case Error(:final exception):
        emit(
          state.copyWith(
            isResending: false,
            status: AppStatus.failure,
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
