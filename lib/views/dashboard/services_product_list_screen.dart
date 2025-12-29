import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_appbar.dart';
import 'package:servicemen_customer_app/providers/cart_provider.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';
import 'package:servicemen_customer_app/views/dashboard/widgets/products_card_widget.dart';

import '../../custom_widgets/custom_button.dart';

class ServicesProductListScreen extends StatelessWidget {
  const ServicesProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, title: "Service name"),
      bottomNavigationBar: buildProceedToOrder(context),
      body: ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 20, top: 30, left: 15, right: 15),
        separatorBuilder: (context, i) => SizedBox(height: 17),
        itemBuilder: (context, i) {
          return ProductCardsWidget(serviceId: i);
        },
      ),
    );
  }

  Widget buildProceedToOrder(BuildContext context) {
    final hasItems = context.select<CartProvider, bool>(
      (p) => p.quantities.isNotEmpty,
    );
    return hasItems
        ? SafeArea(
            child: Container(
              height: 80,
              width: context.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Total price
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.totalPayment,
                        style: AppTextStyles.sf14kGreyW400TextStyle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹ 599",
                        style: AppTextStyles.sf20kBlackSemiboldTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(width: 15),

                  /// Proceed Button
                  Expanded(
                    child: GradientButton(
                      child: Text(
                        context.l10n.proceedToOrder,
                        style: AppTextStyles.sf16kWhiteMediumTextStyle,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.orderSummary);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(height: 1);
  }
}
