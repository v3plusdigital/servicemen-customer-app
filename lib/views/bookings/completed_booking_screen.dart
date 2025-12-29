import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';
import 'package:servicemen_customer_app/views/bookings/widgets/booking_card_widget.dart';
import 'package:servicemen_customer_app/views/bookings/widgets/filter_button_widget.dart';

import '../../models/booking_view_model.dart';
import '../../providers/booking_provider.dart';

class CompletedBookingScreen extends StatelessWidget {
  const CompletedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings =
    context.select<BookingProvider, List<Booking>>(
          (p) => p.filteredBookings,
    );
    return Column(
      children: [
        const SizedBox(height: 20),
        FilterButton(),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            separatorBuilder: (_, __) =>
            const SizedBox(height: 16),
            itemBuilder: (_, i) =>
                BookingCardWidget(booking: bookings[i],status: context.l10n.completed,),
          ),
        ),
      ],
    );
  }
}
