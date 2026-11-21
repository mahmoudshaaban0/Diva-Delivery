import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_shadows.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// In-app notification card (Figma `Courier/Push Banner`): icon box,
/// title, text and the time. Show it with [showAppPushBanner].
class AppPushBanner extends StatelessWidget {
  const AppPushBanner({
    required this.iconAsset,
    required this.title,
    required this.body,
    required this.time,
    super.key,
  });

  /// A 20-px SVG icon, drawn on the dark icon box.
  final String iconAsset;
  final String title;
  final String body;

  /// e.g. "الآن".
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: AppRadius.r24,
        border: Border.all(color: context.colors.surfaceStroke),
        boxShadow: AppShadow.pushBanner,
      ),
      child: Row(
        spacing: 12.w,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.brandPrimary,
              borderRadius: AppRadius.r12,
            ),
            child: AppSvgIcon(
              iconAsset,
              size: 20,
              color: context.colors.buttonPrimary.label,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: [
                AppText(
                  title,
                  style: context.typography.subtitleS,
                  color: context.colors.textTitle,
                  maxLines: 1,
                ),
                AppText(
                  body,
                  style: context.typography.bodyS,
                  color: context.colors.textSubTitle,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          AppText(
            time,
            style: context.typography.bodyXS,
            color: context.colors.textCaption,
          ),
        ],
      ),
    );
  }
}

/// Slides an [AppPushBanner] down from the top of the screen, above
/// everything (dialogs and sheets included). It closes after
/// [duration], when swiped up, or when tapped (then [onTap] runs). A new
/// banner replaces the visible one.
void showAppPushBanner({
  required BuildContext context,
  required AppPushBanner banner,
  VoidCallback? onTap,
  Duration duration = const Duration(seconds: 4),
}) {
  _PushBannerHost._current?.remove();
  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _PushBannerHost(
      banner: banner,
      onTap: onTap,
      duration: duration,
      onDone: () {
        if (_PushBannerHost._current == entry) _PushBannerHost._current = null;
        if (entry.mounted) entry.remove();
      },
    ),
  );
  _PushBannerHost._current = entry;
  Overlay.of(context, rootOverlay: true).insert(entry);
}

class _PushBannerHost extends StatefulWidget {
  const _PushBannerHost({
    required this.banner,
    required this.onTap,
    required this.duration,
    required this.onDone,
  });

  /// The visible banner, so a new one can replace it.
  static OverlayEntry? _current;

  final AppPushBanner banner;
  final VoidCallback? onTap;
  final Duration duration;
  final VoidCallback onDone;

  @override
  State<_PushBannerHost> createState() => _PushBannerHostState();
}

class _PushBannerHostState extends State<_PushBannerHost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late final Animation<Offset> _slide = Tween(
    begin: const Offset(0, -1.4),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _timer = Timer(widget.duration, () => unawaited(_dismiss()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Respect "reduce motion": appear and disappear without sliding.
    if (MediaQuery.disableAnimationsOf(context)) _controller.value = 1;
  }

  Future<void> _dismiss() async {
    _timer?.cancel();
    if (!mounted) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      widget.onDone();
      return;
    }
    await _controller.reverse();
    widget.onDone();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: AppInsets.symmetric(horizontal: 12),
          child: SlideTransition(
            position: _slide,
            child: GestureDetector(
              onTap: () {
                unawaited(_dismiss());
                widget.onTap?.call();
              },
              onVerticalDragEnd: (details) {
                if ((details.primaryVelocity ?? 0) < 0) unawaited(_dismiss());
              },
              child: Material(
                type: MaterialType.transparency,
                child: widget.banner,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
