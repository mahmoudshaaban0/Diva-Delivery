import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

enum AppSwipeButtonState {
  /// Drag the knob to the end to confirm.
  idle,

  /// Knob parked at the end with a spinner, while the action runs.
  checking,

  /// Greyed out, no dragging.
  disabled,
}

/// Swipe-to-confirm button (Figma `Courier/Swipe Button`: Default ·
/// Checking · Disabled).
///
/// The knob starts at the reading start and travels to the reading end
/// (right → left in Arabic). Releasing past 80% calls [onSwiped]; otherwise
/// it springs back. Screen readers get a plain tap action instead.
class AppSwipeButton extends StatefulWidget {
  const AppSwipeButton({
    required this.label,
    required this.onSwiped,
    this.state = AppSwipeButtonState.idle,
    super.key,
  });

  final String label;
  final VoidCallback onSwiped;
  final AppSwipeButtonState state;

  /// Fixed component height (not scaled).
  static const double height = 63;
  static const double _padding = 6;
  static const double _knob = 48;
  static const double _checkingKnob = 36;

  @override
  State<AppSwipeButton> createState() => _AppSwipeButtonState();
}

class _AppSwipeButtonState extends State<AppSwipeButton>
    with SingleTickerProviderStateMixin {
  /// 0 = knob at the start, 1 = knob at the end.
  late final AnimationController _progress = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );

  @override
  void didUpdateWidget(AppSwipeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Back to idle after a check (refused, failed, sheet closed): reset.
    if (widget.state == AppSwipeButtonState.idle &&
        oldWidget.state != AppSwipeButtonState.idle) {
      _progress.value = 0;
    }
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details, double maxTravel) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final delta = (details.primaryDelta ?? 0) * (isRtl ? -1 : 1);
    _progress.value = (_progress.value + delta / maxTravel).clamp(0, 1);
  }

  Future<void> _onDragEnd() async {
    if (_progress.value >= 0.8) {
      await _progress.animateTo(1, curve: Curves.easeOut);
      widget.onSwiped();
    } else {
      await _progress.animateBack(0, curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors.buttonPrimary;
    final (background, foreground) = switch (widget.state) {
      AppSwipeButtonState.idle => (colors.fill, colors.label),
      AppSwipeButtonState.checking => (colors.fillPressed, colors.label),
      AppSwipeButtonState.disabled => (
        context.colors.buttonDisabledFill,
        context.colors.buttonDisabledLabel,
      ),
    };
    final label = AppText(
      widget.label,
      style: context.typography.subtitleL,
      color: foreground,
      textAlign: TextAlign.center,
      maxLines: 1,
    );

    return Semantics(
      button: true,
      enabled: widget.state == AppSwipeButtonState.idle,
      label: widget.label,
      onTap: widget.state == AppSwipeButtonState.idle ? widget.onSwiped : null,
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: AppSwipeButton.height,
        padding: const EdgeInsets.all(AppSwipeButton._padding),
        decoration: BoxDecoration(
          color: background,
          borderRadius: AppRadius.rfull,
        ),
        child: switch (widget.state) {
          AppSwipeButtonState.checking => Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 18.w),
                  child: label,
                ),
              ),
              Container(
                width: AppSwipeButton._checkingKnob,
                height: AppSwipeButton._checkingKnob,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.colors.surfaceBg,
                  shape: BoxShape.circle,
                ),
                child: SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.colors.textTitle,
                  ),
                ),
              ),
            ],
          ),
          AppSwipeButtonState.disabled => Row(
            spacing: 8.w,
            children: [
              _SwipeKnob(color: context.colors.buttonDisabledLabel),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 18.w),
                  child: label,
                ),
              ),
            ],
          ),
          AppSwipeButtonState.idle => LayoutBuilder(
            builder: (context, constraints) {
              final maxTravel = constraints.maxWidth - AppSwipeButton._knob;
              return AnimatedBuilder(
                animation: _progress,
                builder: (context, _) => Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: AppSwipeButton._knob + 8.w,
                        end: 18.w,
                      ),
                      child: Opacity(
                        opacity: 1 - _progress.value,
                        child: Row(
                          children: [
                            Expanded(child: label),
                            for (var i = 0; i < 3; i++)
                              AppSvgIcon(
                                Assets.vectorsIcArrowLeft14,
                                size: 14,
                                color: foreground,
                                flipInLtr: true,
                              ),
                          ],
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: _progress.value * maxTravel,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragUpdate: (d) =>
                            _onDragUpdate(d, maxTravel),
                        onHorizontalDragEnd: (_) => _onDragEnd(),
                        child: _SwipeKnob(color: context.colors.textTitle),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        },
      ),
    );
  }
}

/// The round 48 knob with the arrow (part of [AppSwipeButton]).
class _SwipeKnob extends StatelessWidget {
  const _SwipeKnob({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSwipeButton._knob,
      height: AppSwipeButton._knob,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colors.surfaceBg,
        shape: BoxShape.circle,
      ),
      child: AppSvgIcon(
        Assets.vectorsIcArrowLeft24,
        size: 24,
        color: color,
        flipInLtr: true,
      ),
    );
  }
}
