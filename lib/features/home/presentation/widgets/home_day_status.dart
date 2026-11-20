import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_dot.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/formatters/date_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Date chip + "You haven't started your day yet" / "Your day has started"
/// (Figma "Day Status").
class HomeDayStatus extends StatelessWidget {
  const HomeDayStatus({required this.startedAt, super.key});

  /// Null while the day hasn't started.
  final DateTime? startedAt;

  @override
  Widget build(BuildContext context) {
    final started = startedAt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.h,
      children: [
        Container(
          padding: AppInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: context.colors.buttonNeutral.soft,
            borderRadius: AppRadius.rfull,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6.w,
            children: [
              AppDot(
                color: started == null
                    ? context.colors.textCaption
                    : context.colors.systemGreen,
                size: 6,
              ),
              AppText(
                started == null
                    ? DateFormatter.formatDayAndDate(DateTime.now())
                    : context.localizations.homeDayStartedAt(
                        DateFormatter.formatTime(started),
                      ),
                style: context.typography.subtitle2XS,
              ),
            ],
          ),
        ),
        AppText(
          started == null
              ? context.localizations.homeDayNotStarted
              : context.localizations.homeDayStarted,
          style: context.typography.titleS,
        ),
      ],
    );
  }
}
