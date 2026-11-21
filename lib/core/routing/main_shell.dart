import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_bottom_nav.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

/// The Home · Orders · Profile tab shell (`persistent_bottom_nav_bar_v2`
/// with go_router). Built by the `StatefulShellRoute.indexedStack` in
/// `AppRouter`; each tab is a `StatefulShellBranch`, so every tab keeps its
/// own navigation stack and state while switching.
///
/// The tab order here must match the branch order in `AppRouter`.
class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.router(
      navigationShell: navigationShell,
      backgroundColor: context.colors.surfaceBg,
      navBarBuilder: (navBarConfig) => AppBottomNav(navBarConfig: navBarConfig),
      tabs: [
        PersistentRouterTabConfig(
          item: AppBottomNav.item(
            context,
            title: context.localizations.navHome,
            icon: const AppSvgIcon(Assets.vectorsIcHomeSolid24, size: 24),
          ),
        ),
        PersistentRouterTabConfig(
          // NOTE: the solid "active" icon arrives with Flow 03.
          item: AppBottomNav.item(
            context,
            title: context.localizations.navOrders,
            icon: const AppSvgIcon(Assets.vectorsIcPackage24, size: 24),
          ),
        ),
        PersistentRouterTabConfig(
          item: AppBottomNav.item(
            context,
            title: context.localizations.navProfile,
            icon: const AppSvgIcon(Assets.vectorsIcUserSolid24, size: 24),
            inactiveIcon: const AppSvgIcon(Assets.vectorsIcUser24, size: 24),
          ),
        ),
      ],
    );
  }
}
