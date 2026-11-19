import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/features/auth/presentation/screens/login_screen.dart';
import 'package:limitless_code_template/features/auth/presentation/screens/otp_screen.dart';
import 'package:limitless_code_template/features/home/presentation/screens/home_screen.dart';
import 'package:limitless_code_template/features/splash/presentation/screens/splash_screen.dart';

/// app router
class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        name: AppRoutes.home.name,
        path: AppRoutes.home.path,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        name: AppRoutes.splash.name,
        path: AppRoutes.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.login.name,
        path: AppRoutes.login.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: AppRoutes.otp.name,
        path: AppRoutes.otp.path,
        builder: (context, state) {
          final query = state.uri.queryParameters;
          return OtpScreen(
            phone: query['phone'] ?? '',
            resendAfterSeconds: int.tryParse(query['resendAfter'] ?? ''),
          );
        },
      ),
    ],
  );
}
