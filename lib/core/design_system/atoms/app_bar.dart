import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// The design system's app bar. Pass it to a template's `appBar` slot instead
/// of using Flutter's [AppBar] in screens.
///
/// It uses a surface color that differs from the page background, a bottom
/// border, and shows a back button automatically when the route can pop.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const new({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.onBack,
  });

  /// Plain-text title, rendered with `typography.titleM`.
  final String? title;

  /// Custom title; takes precedence over [title].
  final Widget? titleWidget;

  /// Replaces the automatic back button.
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;

  /// Show a back button when the route can pop and [leading] is null.
  final bool automaticallyImplyLeading;

  /// Overrides the default back behavior (`Navigator.maybePop`).
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    var leadingWidget = leading;
    if (leadingWidget == null && automaticallyImplyLeading && canPop) {
      leadingWidget = IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        color: context.colors.textTitle,
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: onBack ?? () => Navigator.maybePop(context),
      );
    }

    // Match status bar icons to the app bar surface (light icons on dark bg).
    final overlayStyle =
        ThemeData.estimateBrightnessForColor(context.colors.surfaceBg) ==
            Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle.copyWith(statusBarColor: Colors.transparent),
      child: ColoredBox(
        color: context.colors.surfaceBg,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: context.colors.surfaceStroke),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: kToolbarHeight,
              child: NavigationToolbar(
                leading: leadingWidget,
                middle:
                    titleWidget ??
                    (title == null
                        ? null
                        : AppText(
                            title!,
                            style: context.typography.titleM,
                            maxLines: 1,
                          )),
                trailing: actions == null
                    ? null
                    : Row(mainAxisSize: MainAxisSize.min, children: actions!),
                centerMiddle: centerTitle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
