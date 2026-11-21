import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Group title above a run of order cards ("باقي الطلبات · مرتّبة حسب
/// الأقرب إليك", "أمس · 14 نوفمبر", "نتيجة واحدة في الطلبات الحالية").
class OrdersSectionLabel extends StatelessWidget {
  const OrdersSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.typography.subtitleS,
      color: context.colors.textSubTitle,
    );
  }
}
