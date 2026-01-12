import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/models/get_cart_model.dart';
import 'package:servicemen_customer_app/providers/cart_provider.dart';
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
      body: Selector<CartProvider, GetCartModel?>(
        selector: (_, p) => p.getCartModel,
        builder: (_, cartModel, __) {
          return ListView.builder(
            itemCount: cartModel?.data?.carts?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    buildServiceItems(context, cartModel!.data!.carts![i]),
                    SizedBox(height: 15),
                    buildButtons(context, cartModel!.data!.carts![i].id ?? 0),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildServiceItems(BuildContext context, Cart cart) {
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
              image: cart.serviceTypeImageThumb ?? "",
              // AppImages.categoryPlaceholderImage,
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
                    cart.serviceTypeName ?? "",
                    style: AppTextStyles.sf16kBlackW500TextStyle,
                  ),
                  Text(
                    "₹ ${cart.totalAmount}",
                    style: AppTextStyles.sf16kBlackW600TextStyle,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.wp(0.5),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cart.items?.length ?? 0,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, a) => Text(
                        "${cart.items![a].quantity}x ${cart.items![a].serviceName}",
                        style: AppTextStyles.sf14kGreyW400TextStyle,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<CartProvider>().deleteCart(
                        context,
                        cart.id!,
                      );
                    },
                    child: Container(
                      height: 30,
                      width: 30,

                      child: Center(
                        child: AppImageWidget().svgImage(
                          imageName: AppImages.deleteIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildButtons(BuildContext context, int cartId) {
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
            onPressed: () {},
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
              context
                  .read<CartProvider>()
                  .getOrderSummary(context, cartId)
                  .then(
                    (onValue) =>
                        Navigator.pushNamed(context, AppRoutes.orderSummary),
                  );
            },
          ),
        ),
      ],
    );
  }
}
