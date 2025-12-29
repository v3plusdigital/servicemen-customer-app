import 'package:flutter/material.dart';
import 'package:servicemen_customer_app/views/dashboard/widgets/service_detail_widget.dart';

import '../../../custom_widgets/app_image_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_textstyles.dart';
import '../../../utils/build_extention.dart';
import 'add_counter_widget.dart';

class ProductCardsWidget extends StatelessWidget {
  final int serviceId;
  final bool? orderSummary;

  const ProductCardsWidget({
    super.key,
    required this.serviceId,
    this.orderSummary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImageWidget().customNetworkImage(
            radius: 8,
            image: AppImages.servicePlaceholderImage,
            height: orderSummary == true ? 70 : null,
            width: orderSummary == true ? 70 : null,
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
                      "Foam Service",
                      style: AppTextStyles.sf16kBlackW500TextStyle,
                    ),
                    orderSummary == true
                        ? Container(width: 5)
                        : Text(
                            "₹ 599",
                            style: AppTextStyles.sf16kBlackW600TextStyle,
                          ),
                  ],
                ),
                orderSummary == true
                    ? Text(
                        "Service name",
                        style: AppTextStyles.sf14kGreyW400TextStyle,
                      )
                    : Text(
                        "Wash indoor unit with chemical & outdoor unit with water",
                        style: AppTextStyles.sf14kGreyW400TextStyle,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    orderSummary == true
                        ? Text(
                            "₹ 599",
                            style: AppTextStyles.sf16kBlackW600TextStyle,
                          )
                        : GestureDetector(
                            onTap: () {
                              openServiceDetailBottomSheet(context);
                            },
                            child: Text(
                              context.l10n.viewDetails,
                              style: AppTextStyles.sf14kPrimaryW500TextStyle,
                            ),
                          ),

                    AddCounterWidget(serviceId: serviceId),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openServiceDetailBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return serviceDetailBottomSheet(context);
        },
      ),
    );
  }
}
