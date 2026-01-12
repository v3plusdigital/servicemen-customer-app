import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:servicemen_customer_app/models/services_response_model.dart';

import '../../../custom_widgets/app_image_widget.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../models/booking_view_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_textstyles.dart';
import '../../../utils/build_extention.dart';
import '../../dashboard/widgets/products_card_widget.dart';
import 'booking_card_widget.dart';

class AddRatingWidget extends StatelessWidget {
  Booking booking;

  AddRatingWidget({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.addRatting,
                    style: AppTextStyles.sf20kBlackSemiboldTextStyle,
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
              SizedBox(height: 10),
              Text(
                "${context.l10n.howSatisfiedAreYouWithTheTechnicianService}?",
                style: AppTextStyles.sf16kGreyW400TextStyle,
              ),
              SizedBox(height: 10),
              ProductCardsWidget(
                // serviceId: 1,
                isBorder: false,
                orderSummary: false,
                isRatting: true,
                service: Service(
                  id: 1,
                  name: "AC service and repair",
                  description: "Form Service",
                  shortDescription: "Form Service",
                  thumbnail: AppImages.servicePlaceholderImage,
                  price: "599",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Divider(color: AppColors.kGrey4, thickness: 10),
              ),
              technicianCard(context),
              SizedBox(height: 10),
              Text(
                "${context.l10n.rateThisService}",
                style: AppTextStyles.sf16kGreyW400TextStyle,
              ),
              SizedBox(height: 10),
              RatingBar(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 35,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                ratingWidget: RatingWidget(
                  full: const Icon(Icons.star, color: AppColors.kYellow),
                  half: const Icon(Icons.star_half, color: AppColors.kYellow),
                  empty: const Icon(Icons.star_border, color: AppColors.kBlack),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
              ,
              SizedBox(height: 30),
              buildButton(context),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return GradientButton(
      child: Text(
        context.l10n.submit,
        style: AppTextStyles.sf16kWhiteMediumTextStyle,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget technicianCard(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: AppImageWidget().customNetworkImage(
            radius: 5,
            image: AppImages.photoPlaceholderImage,
            height: 50,
            width: 50,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.technician,
              style: AppTextStyles.sf14kGreyW400TextStyle,
            ),
            Text(
              booking.technician ?? 'John Kumar',
              style: AppTextStyles.sf16kBlackW500TextStyle,
            ),
          ],
        ),
      ],
    );
  }
}
