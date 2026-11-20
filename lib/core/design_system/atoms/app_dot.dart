import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';

/// Small filled status circle (order status, range pill, date chip).
///
/// Set [pulse] only for live or attention states (in range, day started,
/// new orders waiting): a ring grows to 3× the dot and fades, and the dot
/// breathes slightly, every ~1.5s. The ring is painted outside the dot, so
/// the layout doesn't change, and it's off when the system asks to reduce
/// motion. Plain legend dots stay still.
class AppDot extends StatefulWidget {
  const AppDot({
    required this.color,
    this.size = 8,
    this.pulse = false,
    super.key,
  });

  final Color color;

  /// Design size (scaled with `.r`). Figma uses 6 and 8.
  final double size;
  final bool pulse;

  @override
  State<AppDot> createState() => _AppDotState();
}

class _AppDotState extends State<AppDot> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(AppDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  /// Runs the pulse only when asked for and motion is allowed.
  void _sync() {
    final animate = widget.pulse && !MediaQuery.disableAnimationsOf(context);
    if (animate && !_pulse.isAnimating) {
      _pulse.repeat();
    } else if (!animate && _pulse.isAnimating) {
      _pulse
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size.r;
    final dot = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
    );
    if (!widget.pulse) return dot;

    return SizedBox.square(
      dimension: size,
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, _) {
          final t = Curves.easeOut.transform(_pulse.value);
          // Dot breathes 1 → 1.15 → 1 over the cycle.
          final breathe =
              1 +
              0.15 *
                  Curves.easeInOut.transform(1 - (2 * _pulse.value - 1).abs());
          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 1 + 2 * t,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.6 * (1 - t)),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Transform.scale(scale: breathe, child: dot),
            ],
          );
        },
      ),
    );
  }
}
