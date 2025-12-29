import 'package:flutter/material.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';

import '../../../models/booking_view_model.dart';

class StatusChip extends StatelessWidget {
  final BookingStatus label;
  final bool bookingDetail;

  const StatusChip(this.label, this.bookingDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bookingStatusColor(context, label),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label.name.toString(),
        style: bookingStatusTextStyle(context, label),
      ),
    );
  }

  Color bookingStatusColor(BuildContext context, BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return AppColors.kGrey5;
      case BookingStatus.inProgress:
        return AppColors.kOrangeLight;
      case BookingStatus.completed:
        return AppColors.kGreenLight;
      case BookingStatus.cancelled:
        return AppColors.kRedLight;
      case BookingStatus.assigned:
        return AppColors.kSkyLight;
    }
  }

  TextStyle bookingStatusTextStyle(BuildContext context, BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return AppTextStyles.sf12kGrey6W400TextStyle;
      case BookingStatus.inProgress:
        return AppTextStyles.sf12kOrangeW400TextStyle;
      case BookingStatus.completed:
        return AppTextStyles.sf12kGreenW400TextStyle;
      case BookingStatus.cancelled:
        return AppTextStyles.sf12kRedW400TextStyle;
      case BookingStatus.assigned:
        return AppTextStyles.sf12kSkyW400TextStyle;
    }
  }
}
