import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/organisms/empty_state.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Orders tab placeholder until Flow 03 (قائمة الطلبات) is built.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceBg,
      body: SafeArea(
        child: EmptyState(
          icon: Icons.inventory_2_outlined,
          message: context.localizations.comingSoon,
        ),
      ),
    );
  }
}
