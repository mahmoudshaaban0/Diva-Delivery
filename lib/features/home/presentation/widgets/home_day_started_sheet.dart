import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_status_sheet.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/data/models/start_day_response_model.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_day_summary_card.dart';

/// "Your day has started" sheet with the day summary (Figma "بدء اليوم –
/// تم بنجاح").
class HomeDayStartedSheet extends StatelessWidget {
  const HomeDayStartedSheet({
    required this.result,
    required this.warehouseName,
    required this.onViewOrders,
    required this.onLater,
    super.key,
  });

  final StartDayResponseModel result;
  final String warehouseName;
  final VoidCallback onViewOrders;
  final VoidCallback onLater;

  @override
  Widget build(BuildContext context) {
    return AppStatusSheet(
      iconAsset: Assets.vectorsIcTick26,
      tone: AppIconBadgeTone.success,
      title: context.localizations.dayStartedTitle,
      subtitle: context.localizations.dayStartedSubtitle(result.ordersCount),
      content: HomeDaySummaryCard(
        warehouseName: warehouseName,
        startedAt: result.startedAt,
        ordersCount: result.ordersCount,
      ),
      primaryLabel: context.localizations.viewOrders,
      onPrimary: onViewOrders,
      secondaryLabel: context.localizations.later,
      onSecondary: onLater,
    );
  }
}
