import 'package:limitless_code_template/core/cubit/base_state.dart';

enum LoginMethod { phone, email }

class LoginState extends BaseState<LoginState> {
  const LoginState({
    super.status,
    super.errorMessage,
    this.method = LoginMethod.phone,
    this.phone,
    this.resendAfterSeconds,
    this.isOffline = false,
  });

  final LoginMethod method;

  /// Phone the OTP was sent to (set on a successful phone submit).
  final String? phone;

  /// Countdown to pass to the OTP screen.
  final int? resendAfterSeconds;

  /// The last failure was a missing connection (shown as a toast).
  final bool isOffline;

  @override
  LoginState copyWith({
    AppStatus? status,
    String? errorMessage,
    LoginMethod? method,
    String? phone,
    int? resendAfterSeconds,
    bool? isOffline,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      method: method ?? this.method,
      phone: phone ?? this.phone,
      resendAfterSeconds: resendAfterSeconds ?? this.resendAfterSeconds,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    method,
    phone,
    resendAfterSeconds,
    isOffline,
  ];
}
