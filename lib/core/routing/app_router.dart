import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/routing/app_routes.dart';
import 'package:limitless_code_template/core/routing/main_shell.dart';
import 'package:limitless_code_template/core/services/permission_service.dart';
import 'package:limitless_code_template/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:limitless_code_template/features/auth/presentation/screens/login_screen.dart';
import 'package:limitless_code_template/features/auth/presentation/screens/otp_screen.dart';
import 'package:limitless_code_template/features/home/presentation/screens/home_screen.dart';
import 'package:limitless_code_template/features/orders/presentation/screens/orders_screen.dart';
import 'package:limitless_code_template/features/permissions/presentation/screens/camera_permission_screen.dart';
import 'package:limitless_code_template/features/permissions/presentation/screens/location_permission_screen.dart';
import 'package:limitless_code_template/features/profile/presentation/screens/profile_screen.dart';
import 'package:limitless_code_template/features/splash/presentation/screens/splash_screen.dart';

/// App routes. Tabs live in the `StatefulShellRoute` (see `MainShell`);
/// everything else is full-screen, above the tab bar.
class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      // Home · Orders · Profile tabs (persistent_bottom_nav_bar_v2). One
      // branch per tab, in the same order as the tabs in `MainShell`; each
      // branch keeps its own navigation stack. Add a tab's inner screens as
      // sub-routes of its branch so the nav bar stays visible on them.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.home.name,
                path: AppRoutes.home.path,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.orders.name,
                path: AppRoutes.orders.path,
                builder: (context, state) => const OrdersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.profile.name,
                path: AppRoutes.profile.path,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
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
      GoRoute(
        name: AppRoutes.forgotPassword.name,
        path: AppRoutes.forgotPassword.path,
        builder: (context, state) => ForgotPasswordScreen(
          initialEmail: state.uri.queryParameters['email'] ?? '',
        ),
      ),
      GoRoute(
        name: AppRoutes.locationPermission.name,
        path: AppRoutes.locationPermission.path,
        // Checked before the screen is built, so an already-granted
        // permission never flashes its screen: go_router waits on the
        // previous screen, then lands on the right one.
        redirect: (context, state) async =>
            await getIt<PermissionService>().isLocationGranted()
            ? AppRoutes.cameraPermission.path
            : null,
        builder: (context, state) => const LocationPermissionScreen(),
      ),
      GoRoute(
        name: AppRoutes.cameraPermission.name,
        path: AppRoutes.cameraPermission.path,
        redirect: (context, state) async =>
            await getIt<PermissionService>().isCameraAndPhotosGranted()
            ? AppRoutes.home.path
            : null,
        builder: (context, state) => const CameraPermissionScreen(),
      ),
    ],
  );
}
