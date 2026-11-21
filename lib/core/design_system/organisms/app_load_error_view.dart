import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_status_view.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Full-screen "couldn't load" state with nothing cached to show (Figma
/// Flow 08):
/// - [isOffline]: red "لا يوجد اتصال بالإنترنت" + retry (the screen should
///   also reload by itself when the connection is back);
/// - otherwise the server failed: yellow "تعذّر تحميل البيانات" + retry +
///   "التواصل مع الدعم".
class AppLoadErrorView extends StatelessWidget {
  const AppLoadErrorView({
    required this.isOffline,
    required this.onRetry,
    required this.onContactSupport,
    this.offlineMessage,
    super.key,
  });

  final bool isOffline;
  final VoidCallback onRetry;
  final VoidCallback onContactSupport;

  /// Replaces the generic offline text, e.g. "… وسنحمّل طلباتك تلقائيًا".
  final String? offlineMessage;

  @override
  Widget build(BuildContext context) {
    return isOffline
        ? AppStatusView(
            size: AppStatusViewSize.compact,
            tone: AppIconBadgeTone.error,
            iconAsset: Assets.vectorsIcWifiOff26,
            title: context.localizations.noInternetConnection,
            message: offlineMessage ?? context.localizations.offlineMessage,
            actionLabel: context.localizations.retry,
            onAction: onRetry,
          )
        : AppStatusView(
            size: AppStatusViewSize.compact,
            tone: AppIconBadgeTone.warning,
            iconAsset: Assets.vectorsIcCloudOff26,
            title: context.localizations.serverErrorTitle,
            message: context.localizations.serverErrorMessage,
            actionLabel: context.localizations.retry,
            onAction: onRetry,
            secondaryActionLabel: context.localizations.contactSupport,
            onSecondaryAction: onContactSupport,
          );
  }
}
