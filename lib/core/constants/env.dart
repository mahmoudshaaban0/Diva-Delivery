/// Compile-time config injected with `--dart-define-from-file=env/<flavor>.json`.
/// Every key must exist in `env/example.json`.
final class Env {
  Env._();

  static const String baseUrl = String.fromEnvironment('BASE_URL');

  // Auth endpoints (relative to [baseUrl]).
  static const String sendOtpEndpoint = String.fromEnvironment(
    'SEND_OTP_ENDPOINT',
  );
  static const String verifyOtpEndpoint = String.fromEnvironment(
    'VERIFY_OTP_ENDPOINT',
  );
  static const String loginEndpoint = String.fromEnvironment('LOGIN_ENDPOINT');
  static const String forgotPasswordEndpoint = String.fromEnvironment(
    'FORGOT_PASSWORD_ENDPOINT',
  );

  // Home (courier day).
  static const String homeEndpoint = String.fromEnvironment('HOME_ENDPOINT');
  static const String startDayEndpoint = String.fromEnvironment(
    'START_DAY_ENDPOINT',
  );

  // Profile.
  static const String profileEndpoint = String.fromEnvironment(
    'PROFILE_ENDPOINT',
  );
  static const String profilePhotoEndpoint = String.fromEnvironment(
    'PROFILE_PHOTO_ENDPOINT',
  );
  static const String logoutEndpoint = String.fromEnvironment(
    'LOGOUT_ENDPOINT',
  );

  // Orders. The details path holds an `{id}` placeholder.
  static const String ordersEndpoint = String.fromEnvironment(
    'ORDERS_ENDPOINT',
  );
  static const String orderDetailsEndpoint = String.fromEnvironment(
    'ORDER_DETAILS_ENDPOINT',
  );

  // Notifications. The read path holds an `{id}` placeholder.
  static const String notificationsEndpoint = String.fromEnvironment(
    'NOTIFICATIONS_ENDPOINT',
  );
  static const String notificationReadEndpoint = String.fromEnvironment(
    'NOTIFICATION_READ_ENDPOINT',
  );
  static const String notificationsReadAllEndpoint = String.fromEnvironment(
    'NOTIFICATIONS_READ_ALL_ENDPOINT',
  );
}
