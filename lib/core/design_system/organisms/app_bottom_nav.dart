import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

/// The app's floating tab bar (Figma `Courier/Bottom Bar` + `Courier/Nav
/// Item`): icon over label on every tab, a soft pill behind the active one.
/// Pass it as the `navBarBuilder` of `PersistentTabView.router` (see
/// `MainShell`) and build each tab with [AppBottomNav.item].
///
/// Switching tabs is animated: the pill slides to the new tab, icon and
/// label colors cross-fade, and the active icon scales up slightly.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({required this.navBarConfig, super.key});

  final NavBarConfig navBarConfig;

  /// Fixed component height (not scaled).
  static const double height = 64;

  static const Duration _duration = Duration(milliseconds: 300);
  static const Curve _curve = Curves.easeOutCubic;

  /// A tab item. [icon] is shown when active (Figma: solid), [inactiveIcon]
  /// otherwise (stroke; defaults to [icon]). Use `AppSvgIcon` without a
  /// color so it takes the animated icon color.
  static ItemConfig item(
    BuildContext context, {
    required String title,
    required Widget icon,
    Widget? inactiveIcon,
  }) => ItemConfig(title: title, icon: icon, inactiveIcon: inactiveIcon);

  @override
  Widget build(BuildContext context) {
    final count = navBarConfig.items.length;

    return ColoredBox(
      color: context.colors.surfaceBg,
      child: SafeArea(
        top: false,
        // Keeps a gap on devices without a home indicator.
        minimum: EdgeInsets.only(bottom: 20.h),
        child: Padding(
          padding: AppInsets.symmetric(horizontal: 20),
          child: Container(
            height: height,
            // Inside the fixed 64 component height, so not scaled.
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: context.colors.brandPrimaryTint,
              borderRadius: AppRadius.rfull,
              border: Border.all(color: context.colors.surfaceStroke),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / count;
                return Stack(
                  children: [
                    // The active pill, sliding between tabs.
                    AnimatedPositionedDirectional(
                      duration: _duration,
                      curve: _curve,
                      start: navBarConfig.selectedIndex * itemWidth,
                      width: itemWidth,
                      top: 0,
                      bottom: 0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.colors.brandPrimarySoft,
                          borderRadius: AppRadius.rfull,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        for (var i = 0; i < count; i++)
                          Expanded(
                            child: _NavItem(
                              item: navBarConfig.items[i],
                              isActive: i == navBarConfig.selectedIndex,
                              onTap: () => navBarConfig.onItemSelected(i),
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final ItemConfig item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final target = isActive
        ? context.colors.brandPrimary
        : context.colors.surfaceIconInactive;

    return Semantics(
      button: true,
      selected: isActive,
      label: item.title,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: TweenAnimationBuilder<Color?>(
          duration: AppBottomNav._duration,
          curve: AppBottomNav._curve,
          tween: ColorTween(end: target),
          builder: (context, color, _) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2.h,
            children: [
              AnimatedScale(
                duration: AppBottomNav._duration,
                curve: AppBottomNav._curve,
                scale: isActive ? 1.08 : 1,
                child: IconTheme.merge(
                  // `AppSvgIcon` without a color picks this up.
                  data: IconThemeData(color: color),
                  child: AnimatedSwitcher(
                    duration: AppBottomNav._duration,
                    child: KeyedSubtree(
                      key: ValueKey(isActive),
                      child: isActive ? item.icon : item.inactiveIcon,
                    ),
                  ),
                ),
              ),
              if (item.title != null)
                AppText(
                  item.title!,
                  style: context.typography.subtitle2XS,
                  color: color,
                  maxLines: 1,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
