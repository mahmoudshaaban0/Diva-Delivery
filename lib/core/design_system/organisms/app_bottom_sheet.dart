import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

enum AppSheetSize { wrap, half, full }

/// ```dart
/// final result = await showAppBottomSheet<String>(
///   context: context,
///   size: AppSheetSize.half,
///   child: MyContent(),
/// );
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  AppSheetSize size = AppSheetSize.half,
  bool isDismissible = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true, // lets the sheet grow past half the screen
    useSafeArea: true,
    isDismissible: isDismissible,
    backgroundColor: Colors.transparent, // _SheetSurface paints the background
    builder: (context) {
      return Padding(
        // keeps the sheet above the keyboard
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: _SheetSurface(
          fill: size == AppSheetSize.full,
          child: switch (size) {
            AppSheetSize.wrap => Flexible(
              child: SingleChildScrollView(child: child),
            ),
            AppSheetSize.half => SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.4,
              child: child,
            ),
            AppSheetSize.full => Expanded(child: child),
          },
        ),
      );
    },
  );
}

/// Shows a sheet the user can drag up and down.
/// [builder] receives a controller: give it to your scrollable
/// (`ListView(controller: controller)`) so dragging and scrolling work together
///
/// ```dart
/// showAppDraggableSheet(
///   context: context,
///   builder: (context, controller) => ListView(controller: controller,
/// );
/// ```
Future<T?> showAppDraggableSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext context, ScrollController controller)
  builder,
  double initialSize = 0.5,
  double minSize = 0.25,
  double maxSize = 0.95,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: initialSize,
        minChildSize: minSize,
        maxChildSize: maxSize,
        builder: (context, controller) {
          return _SheetSurface(
            fill: true,
            child: Expanded(child: builder(context, controller)),
          );
        },
      );
    },
  );
}

/// Rounded top, themed background and the drag handle (Figma
/// `Courier/Bottom Sheet`: surface card, 28 radius, 40×5 grabber).
class _SheetSurface extends StatelessWidget {
  const _SheetSurface({required this.child, required this.fill});

  /// Must be a Flexible/Expanded/sized widget, it is placed in a Column.
  final Widget child;

  /// true: the surface fills the height it is given. false: it hugs its content
  final bool fill;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: fill ? MainAxisSize.max : MainAxisSize.min,
        children: [
          10.vs,
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: context.colors.surfaceLine,
              borderRadius: AppRadius.rfull,
            ),
          ),
          gapH20,
          child,
        ],
      ),
    );
  }
}
