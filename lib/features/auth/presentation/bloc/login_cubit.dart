import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/features/auth/data/repositories/auth_repository.dart';
import 'package:limitless_code_template/features/auth/presentation/bloc/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;

  void selectMethod(LoginMethod method) {
    if (method == state.method || state.status == AppStatus.loading) return;
    emit(state.copyWith(method: method, status: AppStatus.initial));
  }

  /// [phone] is the 9-digit national number (5XXXXXXXX).
  Future<void> sendOtp(String phone) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await _authRepository.sendOtp(phone: phone);
    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            status: AppStatus.success,
            phone: phone,
            resendAfterSeconds: data.resendAfterSeconds,
          ),
        );
      case Error(:final exception):
        emit(
          state.copyWith(
            status: AppStatus.failure,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await _authRepository.loginWithEmail(
      email: email,
      password: password,
    );
    switch (result) {
      case Success():
        // NOTE: persist the session token here once auth storage exists.
        emit(state.copyWith(status: AppStatus.success));
      case Error(:final exception):
        emit(
          state.copyWith(
            status: AppStatus.failure,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }
}
