import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/providers/booking_provider.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';
import 'package:servicemen_customer_app/views/bookings/widgets/status_chip_widget.dart';

import '../../../custom_widgets/custom_button.dart';
import '../../../models/booking_view_model.dart';
import '../../../utils/app_textstyles.dart';
import '../../../utils/build_extention.dart';
import '../booking_details_screen.dart';
import 'add_rating_widget.dart';

class BookingCardWidget extends StatelessWidget {
  final Booking booking;
  final String status;
  final bool? bookingDetail;

  const BookingCardWidget({
    super.key,
    required this.booking,
    required this.status,
    this.bookingDetail,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final bookingProvider = context.read<BookingProvider>();
        bookingProvider.selectBooking(booking);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider.value(
              value: bookingProvider,
              child: const BookingDetailsScreen(),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.kGrey1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    booking.title,
                    style: AppTextStyles.sf16kBlackW500TextStyle,
                  ),
                ),
                bookingDetail == true
                    ? Row(
                        children: [
                          Text(
                            "${context.l10n.orderID}: ",
                            style: AppTextStyles.sf14kBlackW400TextStyle,
                          ),
                          Text(
                            booking.id,
                            style: AppTextStyles.sf14kGreyW400TextStyle,
                          ),
                        ],
                      )
                    : booking.statusLabel == context.l10n.completed ||
                          booking.statusLabel == context.l10n.cancelled
                    ? StatusChip(booking.bookingStatus, false)
                    : Row(
                        children: [
                          StatusChip(booking.bookingStatus, false),
                          SizedBox(width: 10),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: AppImageWidget().svgImage(
                                imageName: AppImages.callIcon,
                                height: 16,
                                width: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
            Divider(color: AppColors.kGrey1, thickness: 1, height: 20),
            bookingDetail == true
                ? (booking.bookingStatus.name.toString() !=
                          BookingStatus.pending.name.toString()
                      ? _technicianCard(context, booking)
                      : Container())
                : Row(
                    children: [
                      Text(
                        "${context.l10n.orderID}: ",
                        style: AppTextStyles.sf14kBlackW400TextStyle,
                      ),
                      Text(
                        booking.id,
                        style: AppTextStyles.sf14kGreyW400TextStyle,
                      ),
                    ],
                  ),
            rowWidget(context.l10n.service, booking.service),
            booking.status == BookingTabStatus.cancelled
                ? rowWidget(
                    context.l10n.cancelledDate,
                    "${booking.cancelledDate.day} Dec 2025",
                  )
                : rowWidget(
                    context.l10n.slotDate,
                    "${booking.slotDate.day} Dec 2025",
                  ),
            booking.status == BookingTabStatus.cancelled
                ? rowWidget(context.l10n.amount, "₹ ${booking.amount}")
                : Container(),
            booking.status == BookingTabStatus.cancelled
                ? rowWidget(
                    context.l10n.refundAmount,
                    "₹ ${booking.refundAmount}",
                  )
                : Container(),
            booking.status == BookingTabStatus.completed
                ? rowWidget(
                    context.l10n.completedDate,
                    "${booking.completedDate.day} Dec 2025",
                  )
                : booking.status == BookingTabStatus.cancelled
                ? Container()
                : rowWidget(context.l10n.slotTime, booking.slotTime),
            bookingDetail == true
                ? rowWidget(context.l10n.amount, "₹ ${booking.amount}")
                : Container(),
            if (booking.status == BookingTabStatus.active &&
                booking.statusLabel == context.l10n.pending &&
                bookingDetail != true) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.wp(0.4),
                    height: 38,
                    child: CustomOutlineButton(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.kRed,
                      child: Text(
                        context.l10n.cancelBooking,
                        style: AppTextStyles.sf14kRedW500TextStyle,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: context.wp(0.4),
                    height: 38,
                    child: GradientButton(
                      radius: 5,
                      child: Text(
                        context.l10n.modifyBooking,
                        style: AppTextStyles.sf16kWhiteMediumTextStyle,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],

            if (booking.status == BookingTabStatus.completed &&
                bookingDetail != true) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.wp(0.4),
                    height: 38,
                    child: CustomOutlineButton(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.kPrimaryColor,
                      child: Text(
                        context.l10n.addRatting,
                        style: AppTextStyles.sf14kPrimaryW500TextStyle,
                      ),
                      onPressed: () {
                        openSheet(
                          context,
                          booking,
                          AddRatingWidget(booking: booking),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: context.wp(0.4),
                    height: 38,
                    child: GradientButton(
                      radius: 5,
                      child: Text(
                        context.l10n.downloadInvoice,
                        style: AppTextStyles.sf16kWhiteMediumTextStyle,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget rowWidget(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$label:", style: AppTextStyles.sf14kGreyW400TextStyle),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.sf14kBlackW500TextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _technicianCard(BuildContext context, Booking booking) {
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
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.kGrey5,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(Icons.star, color: AppColors.kYellow, size: 18),
              Text(
                '${booking.rating ?? 4.7}',
                style: AppTextStyles.sf12kBlackW400TextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void openSheet(BuildContext context, Booking booking, Widget openSheet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.kWhite,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return openSheet;
        },
      ),
    );
  }
}
