import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_appbar.dart';
import 'package:servicemen_customer_app/models/service_view_state.dart';
import 'package:servicemen_customer_app/providers/cart_provider.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';
import 'package:servicemen_customer_app/views/dashboard/widgets/products_card_widget.dart';

import '../../custom_widgets/custom_button.dart';
import '../../models/services_response_model.dart';
import '../../providers/dashboard_provider.dart';

class ServicesProductListScreen extends StatelessWidget {
  const ServicesProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<DashboardProvider, ServicesViewState?>(
      selector: (_, p) => ServicesViewState(
        services: p.servicesResponseModel,
        isLoading: p.isLoading,
      ),
      builder: (_, services, __) {
        return Scaffold(
          appBar: CustomAppBar(
            context: context,
            title: services?.services?.data?.serviceType?.name.toString() ?? "",
          ),
          bottomNavigationBar: buildProceedToOrder(context),
          body: services?.isLoading == true
              ? Container()
              : (services?.services?.data?.services?.length ?? 0) > 0
              ? ListView.separated(
                  itemCount: services?.services?.data?.services?.length ?? 0,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    bottom: 20,
                    top: 30,
                    left: 15,
                    right: 15,
                  ),
                  separatorBuilder: (context, i) => SizedBox(height: 17),
                  itemBuilder: (context, i) {
                    return ProductCardsWidget(
                      service: services?.services!.data!.services![i],
                    );
                  },
                )
              : Center(
                  child: Text(
                    "Services not found",
                    style: AppTextStyles.sf16kPrimaryColorMediumTextStyle,
                  ),
                ),
        );
      },
    );
  }

  Widget buildProceedToOrder(BuildContext context) {
    return Selector<CartProvider, bool>(
      selector: (_, p) => p.quantities.isNotEmpty,
      builder: (context, hasItems, __) {
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
                      Expanded(
                        flex: 7,
                        child: CustomOutlineButton(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                          child: Text(
                            context.l10n.addToCart,
                            style:
                                AppTextStyles.sf16kPrimaryColorMediumTextStyle,
                          ),
                          onPressed: () {
                            context.read<CartProvider>().addToCart(context);
                          },
                        ),
                        // child: Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       context.l10n.totalPayment,
                        //       style: AppTextStyles.sf14kGreyW400TextStyle,
                        //     ),
                        //     const SizedBox(height: 4),
                        //     Text(
                        //       "₹ 599",
                        //       style: AppTextStyles.sf20kBlackSemiboldTextStyle,
                        //     ),
                        //   ],
                        // ),
                      ),
                      Expanded(flex: 1, child: Container()),

                      /// Proceed Button
                      Expanded(
                        flex: 7,
                        child: GradientButton(
                          child: Text(
                            context.l10n.proceedToOrder,
                            style: AppTextStyles.sf16kWhiteMediumTextStyle,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.orderSummary,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(height: 1);
      },
    );
  }
}
