import 'package:flutter/material.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';

import '../../custom_widgets/app_image_widget.dart';
import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_button.dart';
import '../../utils/app_images.dart';
import '../../utils/app_textstyles.dart';
import '../../utils/build_extention.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, title: context.l10n.cart),
      body: ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                buildServiceItems(context),
                SizedBox(height: 15),
                buildButtons(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildServiceItems(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.kGrey3,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.kGrey1, width: 1),
          ),
          child: Center(
            child: AppImageWidget().customNetworkImage(
              radius: 0,
              image: AppImages.categoryPlaceholderImage,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "AC Service & Repair",
                    style: AppTextStyles.sf16kBlackW500TextStyle,
                  ),
                  Text("₹ 599", style: AppTextStyles.sf16kBlackW600TextStyle),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.wp(0.5),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) => Text(
                        "1x Foam Service",
                        style: AppTextStyles.sf14kGreyW400TextStyle,
                      ),
                    ),
                  ),
                  AppImageWidget().svgImage(
                    imageName: AppImages.deleteIcon,
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.wp(0.44),
          child: CustomOutlineButton(
            color: AppColors.kPrimaryColor,
            borderRadius: BorderRadius.circular(8),
            child: Text(
              context.l10n.addServices,
              style: AppTextStyles.sf16kPrimaryColorMediumTextStyle,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(
          width: context.wp(0.44),
          child: GradientButton(
            child: Text(
              context.l10n.checkout,
              style: AppTextStyles.sf16kWhiteMediumTextStyle,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.orderSummary);
            },
          ),
        ),
      ],
    );
  }
}
