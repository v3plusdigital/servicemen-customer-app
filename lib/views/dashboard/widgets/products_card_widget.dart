import 'package:flutter/material.dart';

import 'package:servicemen_customer_app/views/dashboard/widgets/service_detail_widget.dart';

import '../../../custom_widgets/app_image_widget.dart';
import '../../../models/services_response_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_textstyles.dart';
import '../../../utils/build_extention.dart';
import 'add_counter_widget.dart';

class ProductCardsWidget extends StatelessWidget {
  // final int serviceId;
  final bool? orderSummary;
  final Service? service;
  final bool? isBorder;
  final bool? isRatting;

  const ProductCardsWidget({
    super.key,
    // required this.serviceId,
    this.orderSummary,
    this.service,
    this.isBorder,
    this.isRatting,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: orderSummary == true
            ? Border(bottom: BorderSide(color: AppColors.kGrey1))
            : isBorder == null || isBorder == true
            ? Border.all(color: AppColors.kGrey1, width: 1)
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImageWidget().customNetworkImage(
            radius: 8,
            image: service != null
                ? service!.thumbnail.toString()
                : AppImages.servicePlaceholderImage,
            height: orderSummary == true || isRatting == true ? 70 : 90,
            width: orderSummary == true || isRatting == true ? 70 : 90,
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
                      service != null ? service!.name.toString() : "",
                      style: AppTextStyles.sf16kBlackW500TextStyle,
                    ),
                    orderSummary == true
                        ? Container(width: 5)
                        : Text(
                            service != null ? "₹ ${service!.price}" : "₹ 599",
                            style: AppTextStyles.sf16kBlackW600TextStyle,
                          ),
                  ],
                ),
                Text(
                  service != null ? service!.shortDescription.toString() : "",
                  style: AppTextStyles.sf14kGreyW400TextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    orderSummary == true
                        ? Text(
                            "₹ ${service?.price}",
                            style: AppTextStyles.sf16kBlackW600TextStyle,
                          )
                        : isRatting == true
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              openServiceDetailBottomSheet(context, service);
                            },
                            child: Text(
                              context.l10n.viewDetails,
                              style: AppTextStyles.sf14kPrimaryW500TextStyle,
                            ),
                          ),

                    isRatting == true
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: AddCounterWidget(
                              serviceId: service?.id ?? 0,
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openServiceDetailBottomSheet(BuildContext context, Service? service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return serviceDetailBottomSheet(context, service);
        },
      ),
    );
  }
}
