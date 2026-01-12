import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../custom_widgets/app_image_widget.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../models/services_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_textstyles.dart';
import '../../../utils/build_extention.dart';
import 'add_counter_widget.dart';

Widget serviceDetailBottomSheet(BuildContext context, Service? service) {
  final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

  return Padding(
    padding: EdgeInsets.only(bottom: bottomPadding),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            /// Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
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
            ),

            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppImageWidget().customNetworkImage(
                    radius: 8,
                    height: 90,
                    width: 90,
                    image: service != null
                        ? service.thumbnail.toString()
                        : AppImages.servicePlaceholderImage,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service != null
                              ? service.name.toString()
                              : "Foam Service",
                          style: AppTextStyles.sf16kBlackW500TextStyle,
                        ),
                        Text(
                          service != null
                              ? service.shortDescription.toString()
                              : "Wash indoor unit with chemicalfgsgfdggd & outdoor unit with water",
                          style: AppTextStyles.sf14kGreyW400TextStyle,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              service != null
                                  ? "₹ ${service.price.toString()}"
                                  : "₹ 599",
                              style: AppTextStyles.sf16kBlackW600TextStyle,
                            ),
                            service != null? Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: AddCounterWidget(serviceId: service.id!),
                            ):
                            CustomOutlineButton(
                              height: 35,
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
            ),
            Divider(color: AppColors.kGrey4, thickness: 10, height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                context.l10n.serviceDetails,
                style: AppTextStyles.sf16kBlackW600TextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: service != null
                  ? Html(
                      data: service.description, // your API html string
                    ):Container(height: 10,)
                 /* : ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 8, bottom: 20),
                      separatorBuilder: (context, i) => SizedBox(height: 5),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) => Text(
                        "• Applicable for both spilt & window Ac",
                        style: AppTextStyles.sf14kGreyW400TextStyle,
                      ),
                    ),*/
            ),
          ],
        ),
      ),
    ),
  );
}
