import 'package:flutter/material.dart';

import '../../../custom_widgets/app_image_widget.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../models/booking_view_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_textstyles.dart';
import '../../../utils/build_extention.dart';

class CancelBookingWidget extends StatelessWidget {
  Booking booking;
   CancelBookingWidget({super.key,required this.booking});

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
                    context.l10n.cancelBooking,
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
              SizedBox(height: 10,),
              Text(
                "${context.l10n.areYouSureYouWantToCancelThis} ${booking.service.toString()} (${booking.title.toString()})?",
                style: AppTextStyles.sf16kGreyW400TextStyle,
              ),
              SizedBox(height: 10,),
              Text(
                "${context.l10n.accordingToOurPolicyYouWillReceiveAn} 80% ${context.l10n.refund}",
                style: AppTextStyles.sf16kGreyW400TextStyle,
              ),

              SizedBox(height: 12),
              addNoteForCancel(context),
              SizedBox(height: 20),
              buildButton(context),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget addNoteForCancel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.addReasonForCancellation,
            style: AppTextStyles.sf16kBlackW400TextStyle,
          ),
          SizedBox(height: 10),
          CustomTextField(hintText: context.l10n.writeHere, maxLines: 4),
        ],
      ),
    );
  }
  Widget buildButton(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.wp(0.41),
          height: 48,
          child: CustomOutlineButton(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.kRed,
            child: Text(
              context.l10n.no,
              style: AppTextStyles.sf14kRedW500TextStyle,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(
          width: context.wp(0.41),
          height: 48,
          child: GradientButton(
            radius: 5,
            child: Text(
              context.l10n.yesCancel,
              style: AppTextStyles.sf16kWhiteMediumTextStyle,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
