import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/organisms/empty_state.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Profile tab placeholder until Flow 07 (الملف الشخصي) is built.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surfaceBg,
      body: SafeArea(
        child: EmptyState(
          icon: Icons.person_outline,
          message: context.localizations.comingSoon,
        ),
      ),
    );
  }
}
