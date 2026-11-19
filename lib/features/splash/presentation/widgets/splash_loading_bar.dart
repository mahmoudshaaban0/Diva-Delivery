import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';

/// Indeterminate 96×4 pill with a 40-wide value sliding across it
/// (Figma "Progress").
class SplashLoadingBar extends StatefulWidget {
  const SplashLoadingBar({required this.track, required this.value, super.key});

  final Color track;
  final Color value;

  @override
  State<SplashLoadingBar> createState() => SplashLoadingBarState();
}

class SplashLoadingBarState extends State<SplashLoadingBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat(reverse: true);

  static const double _width = 96;
  static const double _valueWidth = 40;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width.w,
      height: 4,
      decoration: BoxDecoration(
        color: widget.track,
        borderRadius: AppRadius.rfull,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = Curves.easeInOut.transform(_controller.value);
          return Align(
            // Starts at the reading start (right in Arabic), like Figma.
            alignment: AlignmentDirectional(-1 + 2 * t, 0),
            child: child,
          );
        },
        child: Container(
          width: _valueWidth.w,
          height: 4,
          decoration: BoxDecoration(
            color: widget.value,
            borderRadius: AppRadius.rfull,
          ),
        ),
      ),
    );
  }
}
