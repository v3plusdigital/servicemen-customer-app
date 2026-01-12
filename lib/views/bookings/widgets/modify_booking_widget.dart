import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/providers/booking_provider.dart';

import '../../../custom_widgets/app_image_widget.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../models/booking_view_model.dart';
import '../../../providers/cart_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_textstyles.dart';
import '../../../utils/build_extention.dart';
import '../../dashboard/widgets/horizontal_calendar_widget.dart';

class ModifyBookingWidget extends StatelessWidget {
  Booking booking;
   ModifyBookingWidget({super.key,required this.booking});

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
                    context.l10n.modifyBooking,
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
                "${context.l10n.areYouSureYouWantToModifyThis} ${booking.title.toString()} ${context.l10n.booking.toLowerCase()}?",
                style: AppTextStyles.sf16kGreyW400TextStyle,
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    "${context.l10n.service}: ",
                    style: AppTextStyles.sf14kGreyW400TextStyle,
                  ),
                  Text(
                    booking.service,
                    style: AppTextStyles.sf14kBlackW500TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "${context.l10n.date}: ",
                    style: AppTextStyles.sf14kGreyW400TextStyle,
                  ),
                  Text(
                   "22 Nov 2025",
                    style: AppTextStyles.sf14kBlackW500TextStyle,
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Text(
                context.l10n.changeDate,
                style: AppTextStyles.sf16kBlackW600TextStyle,
              ),
              SizedBox(height: 10),
              MonthlyWeeklyCalendar(
                startDate: DateTime.now(),
                onDateSelected: (date) {
                  debugPrint("Selected date: $date");
                },
              ),
              SizedBox(height: 15),
              Text(
                context.l10n.selectSlot,
                style: AppTextStyles.sf16kBlackW400TextStyle,
              ),
              SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  const itemsPerRow = 4;
                  const spacing = 12.0;

                  final totalSpacing = spacing * (itemsPerRow - 1);
                  final itemWidth =
                      (constraints.maxWidth - totalSpacing) / itemsPerRow;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 16,
                    children: context.read<CartProvider>().timeSlotList.map((
                      e,
                    ) {
                      bool val = context.select<CartProvider, bool>(
                        (p) => p.selectedSlot == e,
                      );
                      return GestureDetector(
                        onTap: () => context.read<CartProvider>().selectSlot(e),
                        child: Container(
                          width: itemWidth,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: val
                                ? AppColors.kPrimaryColor
                                : AppColors.kWhite,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: val
                                  ? AppColors.kTransparent
                                  : AppColors.kGrey1,
                            ),
                          ),
                          child: Text(
                            e,
                            style: val
                                ? AppTextStyles.sf12kWhiteW400TextStyle
                                : AppTextStyles.sf12kBlackW400TextStyle,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: 12),
              addTechnicianNote(context),
              SizedBox(height: 20),
              buildButton(context),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget addTechnicianNote(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.addNoteForTechnicians,
          style: AppTextStyles.sf16kBlackW400TextStyle,
        ),
        SizedBox(height: 10),
        CustomTextField(hintText: context.l10n.writeYourNote, maxLines: 4),
      ],
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
              context.l10n.yes,
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
