import 'package:flutter/material.dart';

import '../../../custom_widgets/app_image_widget.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_textstyles.dart';
import '../../../utils/build_extention.dart';

Widget serviceDetailBottomSheet(BuildContext context) {
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
                    context.l10n.serviceInfo,
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

            SizedBox(height: 15),
            Row(
              children: [
                AppImageWidget().customNetworkImage(
                  radius: 8,
                  image: AppImages.servicePlaceholderImage,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Foam Service",
                        style: AppTextStyles.sf16kBlackW500TextStyle,
                      ),
                      Text(
                        "Wash indoor unit with chemicalfgsgfdggd & outdoor unit with water",
                        style: AppTextStyles.sf14kGreyW400TextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹ 599",
                            style: AppTextStyles.sf16kBlackW600TextStyle,
                          ),
                          CustomOutlineButton(
                            height: 38,
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.kGrey1,
                            child: Text(
                              context.l10n.add,
                              style: AppTextStyles.sf14kPrimaryW400TextStyle,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Divider(color: AppColors.kGrey4, thickness: 10),
            ),
            Text(
              context.l10n.serviceDetails,
              style: AppTextStyles.sf16kBlackW600TextStyle,
            ),
            ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 8, bottom: 20),
              separatorBuilder: (context, i) => SizedBox(height: 5),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => Text(
                "• Applicable for both spilt & window Ac",
                style: AppTextStyles.sf14kGreyW400TextStyle,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}