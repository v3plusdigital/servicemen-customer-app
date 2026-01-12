import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_appbar.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/views/bookings/widgets/booking_card_widget.dart';
import 'package:servicemen_customer_app/views/bookings/widgets/cancel_booking_widget.dart';
import 'package:servicemen_customer_app/views/bookings/widgets/modify_booking_widget.dart';
import 'package:servicemen_customer_app/views/bookings/widgets/status_chip_widget.dart';

import '../../custom_widgets/custom_button.dart';
import '../../models/booking_view_model.dart';
import '../../providers/booking_provider.dart';
import '../../utils/app_textstyles.dart';
import '../../utils/build_extention.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (_, provider, val) {
        final booking = provider.selectedBooking;

        return Scaffold(
          appBar: CustomAppBar(
            context: context,
            title: context.l10n.bookingDetails,
            actionWidget: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: StatusChip(booking!.bookingStatus, true),
              ),
            ],
          ),
          bottomNavigationBar: buildBottom(context, booking!),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingCardWidget(
                  booking: booking,
                  status: context.l10n.active,
                  bookingDetail: true,
                ),
                const SizedBox(height: 25),

                Text(
                  booking.bookingStatus.name.toString() ==
                          BookingStatus.pending.name.toString()
                      ? context.l10n.addReasonForCancellation
                      : context.l10n.addedProblemDescriptions,
                  style: AppTextStyles.sf16kBlackW600TextStyle,
                ),
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Cras fusce habitasse viverra aliquam. Ac in elementum gravida vitae placerat quisque.",
                  style: AppTextStyles.sf16kGreyW400TextStyle,
                ),
                const SizedBox(height: 25),
                booking.bookingStatus.name.toString() ==
                    BookingStatus.pending.name.toString()?Column(
                  children: [
                    Text(
                     context.l10n.notes,
                      style: AppTextStyles.sf16kGreyW400TextStyle,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet consectetur. Cras fusce habitasse viverra aliquam. Ac in elementum gravida vitae placerat quisque.",
                      style: AppTextStyles.sf16kGreyW400TextStyle,
                    ),
                  ],
                ): TrackStatusWidget(status: booking.bookingStatus),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildBottom(BuildContext context, Booking booking) {
    return booking.bookingStatus.name.toString() ==
            BookingStatus.pending.name.toString()
        ? SafeArea(
            child: Container(
              height: 80,
              width: context.width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.wp(0.43),
                    height: 38,
                    child: CustomOutlineButton(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.kRed,
                      child: Text(
                        context.l10n.cancelBooking,
                        style: AppTextStyles.sf14kRedW500TextStyle,
                      ),
                      onPressed: () {
                        openModifyBookingSheet(
                          context,
                          booking,
                          CancelBookingWidget(booking: booking),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: context.wp(0.43),
                    height: 38,
                    child: GradientButton(
                      radius: 5,
                      child: Text(
                        context.l10n.modifyBooking,
                        style: AppTextStyles.sf16kWhiteMediumTextStyle,
                      ),
                      onPressed: () {
                        openModifyBookingSheet(
                          context,
                          booking,
                          ModifyBookingWidget(booking: booking),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(height: 1);
  }

  void openModifyBookingSheet(
    BuildContext context,
    Booking booking,
    Widget openSheet,
  ) {
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

class TrackStatusWidget extends StatelessWidget {
  final BookingStatus status;

  const TrackStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.trackStatus,
          style: AppTextStyles.sf16kBlackW600TextStyle,
        ),
        const SizedBox(height: 20),

        _row(context.l10n.pending, context, isDone: true, showLine: true),
        _row(
          context.l10n.assigned,
          context,
          isDone: status.index >= BookingStatus.assigned.index,
          showLine: true,
        ),
        _row(
          context.l10n.inProgress,
          context,
          isDone: status.index >= BookingStatus.inProgress.index,
          showLine: true,
        ),
        _row(
          context.l10n.completed,
          context,
          isDone: status == BookingStatus.completed,
          showLine: false,
        ),
      ],
    );
  }

  Widget _row(
    String text,
    BuildContext context, {
    required bool isDone,
    required bool showLine,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            isDone
                ? (context.l10n.inProgress == text
                      ? _dashedCircle(isProgress: true)
                      : _doneCircle())
                : _dashedCircle(),
            if (showLine)
              Container(
                height: 30,
                width: 1,
                color: isDone ? AppColors.kGreen : AppColors.kGrey1,
              ),
          ],
        ),
        const SizedBox(width: 16),
        context.l10n.inProgress == text
            ? Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text, style: AppTextStyles.sf16kBlackW400TextStyle),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: context
                                .l10n
                                .technicianUpdatePendingYourApproval,
                            style: AppTextStyles.sf14kGreyW400TextStyle,
                          ),
                          TextSpan(
                            text: context.l10n.pleaseReviewToProceed,
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: AppTextStyles.sf14kPrimaryW400TextStyle
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(text, style: AppTextStyles.sf16kBlackW400TextStyle),
              ),
      ],
    );
  }

  /// ✅ Green completed circle
  Widget _doneCircle() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.kGreen, width: 1),
      ),
      child: Center(
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.kGreen, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: AppImageWidget().svgImage(
              imageName: AppImages.checkIcon,
              width: 15,
              height: 15,
              color: AppColors.kGreen,
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Dashed inactive circle (MATCHES DESIGN)
  Widget _dashedCircle({bool? isProgress}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isProgress == true ? AppColors.kOrange : AppColors.kGrey1,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 25,
          height: 25,
          child: Center(
            child: CustomPaint(
              painter: DashedCirclePainter(isProgress: isProgress),
              child: Container(),
            ),
          ),
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  bool? isProgress;

  DashedCirclePainter({this.isProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isProgress == true ? AppColors.kOrange : AppColors.kGrey1
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashLength = 4;
    const gapLength = 3;
    double startAngle = 0;

    final radius = size.width / 2;
    final circumference = 2 * 3.141592653589793 * radius;
    final dashCount = (circumference / (dashLength + gapLength)).floor();

    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        dashLength / radius,
        false,
        paint,
      );
      startAngle += (dashLength + gapLength) / radius;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
