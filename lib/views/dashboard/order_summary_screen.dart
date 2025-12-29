import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_text_field.dart';
import 'package:servicemen_customer_app/providers/cart_provider.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';
import 'package:servicemen_customer_app/views/dashboard/widgets/horizontal_calendar_widget.dart';
import 'package:servicemen_customer_app/views/dashboard/widgets/products_card_widget.dart';

import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_textstyles.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, title: context.l10n.orderSummary),
      bottomNavigationBar: buildProceedToOrder(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              itemCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 15, left: 15, right: 15),
              separatorBuilder: (context, i) => SizedBox(height: 17),
              itemBuilder: (context, i) {
                return ProductCardsWidget(serviceId: i, orderSummary: true);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Divider(color: AppColors.kGrey4, thickness: 10),
            ),
            buildPaymentSummary(context),
            addProblemDescription(context),
            serviceLocation(context),
            technicianArrival(context),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentSummary(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.paymentSummary,
            style: AppTextStyles.sf20kBlackSemiboldTextStyle,
          ),

          ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 10),
            separatorBuilder: (context, i) => SizedBox(height: 2),
            itemBuilder: (context, i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${i + 1} X Form Service",
                    style: AppTextStyles.sf16kGreyW400TextStyle,
                  ),
                  Text("₹ 599", style: AppTextStyles.sf16kBlackW600TextStyle),
                ],
              );
            },
          ),
          Divider(color: AppColors.kGrey1, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.totalPayment,
                style: AppTextStyles.sf16kBlackW600TextStyle,
              ),
              Text(
                "₹ 599",
                style: AppTextStyles.sf16kPrimaryColorW600TextStyle,
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Divider(color: AppColors.kGrey4, thickness: 10),
          ),
        ],
      ),
    );
  }

  Widget addProblemDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.addProblemDescriptions,
            style: AppTextStyles.sf20kBlackSemiboldTextStyle,
          ),
          SizedBox(height: 10),
          CustomTextField(hintText: context.l10n.writeYourNote, maxLines: 4),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Divider(color: AppColors.kGrey4, thickness: 10),
          ),
        ],
      ),
    );
  }

  Widget serviceLocation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.serviceLocation,
                style: AppTextStyles.sf20kBlackSemiboldTextStyle,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.addressList);
                },
                child: Text(
                  context.l10n.changeLocation,
                  style: AppTextStyles.sf14kPrimaryW500TextStyle,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.kGrey1),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [AppColors.kGrey3, AppColors.kWhite],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Home", style: AppTextStyles.sf16kBlackW500TextStyle),
                Text(
                  "403, Mariya Palace, Near chintamani jain derasar, Shahpore, Surat",
                  style: AppTextStyles.sf14kGreyW400TextStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: AppColors.kGrey4, thickness: 10),
          ),
        ],
      ),
    );
  }

  Widget technicianArrival(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.yourTechnicianArrival,
            style: AppTextStyles.sf20kBlackSemiboldTextStyle,
          ),
          SizedBox(height: 10),
          MonthlyWeeklyCalendar(
            startDate: DateTime.now(),
            onDateSelected: (date) {
              debugPrint("Selected date: $date");
            },
          ),
          SizedBox(height: 15,),
          Text(
            context.l10n.selectSlot,
            style: AppTextStyles.sf16kBlackW400TextStyle,
          ),
          SizedBox(height: 12,),
          LayoutBuilder(
            builder: (context, constraints) {
              const itemsPerRow = 4;
              const spacing = 12.0;

              final totalSpacing = spacing * (itemsPerRow - 1);
              final itemWidth =
                  (constraints.maxWidth - totalSpacing) / itemsPerRow;

              return Wrap(
                spacing: spacing,
                runSpacing: 16,
                children: context.read<CartProvider>().timeSlotList.map((e) {
                  bool val = context.select<CartProvider, bool>(
                    (p) => p.selectedSlot == e,
                  );
                  return GestureDetector(
                    onTap: () => context.read<CartProvider>().selectSlot(e),
                    child: Container(
                      width: itemWidth,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: val ? AppColors.kPrimaryColor : AppColors.kWhite,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: val
                              ? AppColors.kTransparent
                              : AppColors.kGrey1,
                        ),
                      ),
                      child: Text(
                        e,
                        style: val
                            ? AppTextStyles.sf12kWhiteW400TextStyle
                            : AppTextStyles.sf12kBlackW400TextStyle,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          SizedBox(height: 70),
        ],
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  context.l10n.proceedToPayment,
                  style: AppTextStyles.sf16kWhiteMediumTextStyle,
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, AppRoutes.orderSummary);
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
