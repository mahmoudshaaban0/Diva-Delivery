import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:limitless_code_template/core/config/di/injectable.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_circle_icon_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_footer_bar.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_page_header.dart';
import 'package:limitless_code_template/core/design_system/organisms/app_toast.dart';
import 'package:limitless_code_template/core/design_system/organisms/error_state.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/formatters/ltr_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';
import 'package:limitless_code_template/features/orders/presentation/bloc/order_details_cubit.dart';
import 'package:limitless_code_template/features/orders/presentation/bloc/order_details_state.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_details_customer_card.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_details_info_card.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_details_payment_card.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_details_products_card.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_details_proof_card.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_details_skeleton.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_details_summary_card.dart';

/// Figma: Flow 03 · "تفاصيل الطلب" (current and past). Current orders get
/// the "الذهاب للعميل" footer; delivered ones show "إثبات التسليم".
class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({required this.id, this.order, super.key});

  final String id;

  /// The list item that was tapped, so the header shows right away while
  /// the details load. Null when opened from a link.
  final OrderModel? order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final OrderDetailsCubit _cubit = getIt<OrderDetailsCubit>();

  @override
  void initState() {
    super.initState();
    unawaited(_cubit.getDetails(widget.id));
  }

  @override
  void dispose() {
    unawaited(_cubit.close());
    super.dispose();
  }

  Future<void> _onCall(OrderModel order) async {
    final called = await _cubit.callCustomer(order);
    if (!called && mounted) {
      context.showToast(message: context.localizations.callFailed);
    }
  }

  Future<void> _onNavigate(OrderModel order) async {
    final opened = await _cubit.navigateTo(order);
    if (!opened && mounted) {
      context.showToast(
        message: context.localizations.mapsFailed,
        bottomMargin: order.status.isCurrent ? AppToast.aboveFooterMargin : 16,
      );
    }
  }

  Future<void> _onCopy(String text, {required bool aboveFooter}) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    context.showToast(
      message: context.localizations.copied,
      bottomMargin: aboveFooter ? AppToast.aboveFooterMargin : 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          final details = state.details;
          final order = details?.order ?? widget.order;
          final nationalAddress = details?.nationalAddress;

          return Scaffold(
            backgroundColor: context.colors.surfaceBg,
            body: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppPageHeader(
                    title: context.localizations.orderDetailsTitle,
                    subtitle: order == null
                        ? null
                        : context.localizations.orderDetailsSubtitle(
                            LtrFormatter.code(order.code),
                            order.customerName,
                          ),
                    onBack: () => context.pop(),
                    action: order == null
                        ? null
                        : AppCircleIconButton(
                            tooltip: context.localizations.callCustomer,
                            onPressed: () => unawaited(_onCall(order)),
                            icon: AppSvgIcon(
                              Assets.vectorsIcCall22,
                              size: 22,
                              color: context.colors.textTitle,
                            ),
                          ),
                  ),
                  Expanded(
                    child: details == null
                        ? state.status == AppStatus.failure
                              ? ErrorState(
                                  message: state.isOffline
                                      ? context
                                            .localizations
                                            .noInternetConnection
                                      : context
                                            .localizations
                                            .orderDetailsLoadError,
                                  retryLabel: context.localizations.retry,
                                  onRetry: () =>
                                      unawaited(_cubit.getDetails(widget.id)),
                                )
                              : const OrderDetailsSkeleton()
                        : SingleChildScrollView(
                            padding:
                                AppInsets.only(
                                  start: 20,
                                  end: 20,
                                  top: 16,
                                  bottom: 24,
                                ).add(
                                  EdgeInsets.only(
                                    bottom: details.order.status.isCurrent
                                        ? 0
                                        : MediaQuery.paddingOf(context).bottom,
                                  ),
                                ),
                            child: Column(
                              spacing: 12.h,
                              children: [
                                OrderDetailsInfoCard(
                                  order: details.order,
                                  onCopyCode: () => unawaited(
                                    _onCopy(
                                      details.order.code,
                                      aboveFooter:
                                          details.order.status.isCurrent,
                                    ),
                                  ),
                                ),
                                OrderDetailsCustomerCard(
                                  order: details.order,
                                  nationalAddress: nationalAddress,
                                  onOpenMap: () =>
                                      unawaited(_onNavigate(details.order)),
                                  onCopyNationalAddress: () => unawaited(
                                    _onCopy(
                                      nationalAddress ?? '',
                                      aboveFooter:
                                          details.order.status.isCurrent,
                                    ),
                                  ),
                                ),
                                OrderDetailsProductsCard(
                                  products: details.products,
                                ),
                                OrderDetailsPaymentCard(order: details.order),
                                OrderDetailsSummaryCard(details: details),
                                if (details.hasProofOfDelivery)
                                  OrderDetailsProofCard(details: details),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar:
                details != null && details.order.status.isCurrent
                ? AppFooterBar(
                    child: AppFilledButton(
                      onPressed: () => unawaited(_onNavigate(details.order)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4.w,
                        children: [
                          AppSvgIcon(
                            Assets.vectorsIcNavigation22,
                            size: 22,
                            color: context.colors.buttonPrimary.label,
                          ),
                          AppText(
                            context.localizations.goToCustomer,
                            style: context.typography.subtitleM.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            color: context.colors.buttonPrimary.label,
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
