import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_chip.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/notifications/presentation/bloc/notifications_state.dart';

/// "الكل · الطلبات · التحصيل · التنبيهات" chips; scrolls sideways when
/// they don't fit (long English labels).
class NotificationsFilters extends StatelessWidget {
  const NotificationsFilters({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final NotificationsFilter selected;
  final ValueChanged<NotificationsFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8.w,
        children: [
          for (final filter in NotificationsFilter.values)
            AppChip(
              label: switch (filter) {
                NotificationsFilter.all =>
                  context.localizations.notificationsFilterAll,
                NotificationsFilter.orders =>
                  context.localizations.notificationsFilterOrders,
                NotificationsFilter.collection =>
                  context.localizations.notificationsFilterCollection,
                NotificationsFilter.alerts =>
                  context.localizations.notificationsFilterAlerts,
              },
              selected: selected == filter,
              onTap: () => onChanged(filter),
            ),
        ],
      ),
    );
  }
}
