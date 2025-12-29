import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/providers/location_provider.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';

import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_textstyles.dart';
import '../../utils/build_extention.dart';


class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: context.l10n.address,
        actionWidget: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, AppRoutes.chooseAddress);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "+${context.l10n.addAddress}",
                style: AppTextStyles.sf14kPrimaryW500TextStyle,
              ),
            ),
          ),
        ],
      ),
      body: Selector<LocationProvider, int>(
        selector: (_, p) => p.selectedAddress,
        builder: (context, p, w) => ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          itemCount: 4,
          separatorBuilder: (context, i) => SizedBox(height: 15),
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.kGrey1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          openChangeAddressBottomSheet(context,i);

                        },
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: p == i
                                      ? AppColors.kPrimaryColor
                                      : AppColors.kGrey1,
                                  width: 2,
                                ),
                              ),
                              child: p == i
                                  ? Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.kPrimaryColor,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            Text(
                              "Home",
                              style: AppTextStyles.sf16kBlackW500TextStyle,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          AppImageWidget().svgImage(
                            imageName: AppImages.editIcon,
                            width: 15,
                            height: 20,
                          ),
                          SizedBox(width: 8),
                          AppImageWidget().svgImage(
                            imageName: AppImages.deleteIcon,
                            width: 15,
                            height: 20,
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () =>
                        openChangeAddressBottomSheet(context,i),
                    child: Text(
                      "403, Mariya Palace, Near chintamani jain derasar, Shahpore, Surat",
                      style: AppTextStyles.sf14kGreyW400TextStyle,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

 Widget  changeAddressBottomSheet(BuildContext context,int i) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.changeAddress,
                      style: AppTextStyles.sf20kBlackSemiboldTextStyle,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppImageWidget().svgImage(
                      imageName: AppImages.closeIcon,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.doYouWantToUpdateYourLocation,
                style: AppTextStyles.sf16kGreyW400TextStyle,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.wp(0.44),
                    child: CustomOutlineButton(

                      borderRadius: BorderRadius.circular(8),
                      child: Text(
                        context.l10n.no,
                        style: AppTextStyles.sf14kGreyW400TextStyle,
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
                        context.l10n.yes,
                        style: AppTextStyles.sf16kWhiteMediumTextStyle,
                      ),
                      onPressed: () {
                        context.read<LocationProvider>().selectMainAddress(i);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void openChangeAddressBottomSheet(BuildContext context,int i) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
          builder: (context, setState) {
            return  changeAddressBottomSheet(context,i);
          }
      ),
    );
  }
}
