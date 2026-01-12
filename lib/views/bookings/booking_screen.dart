import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';
import 'package:servicemen_customer_app/views/bookings/active_booking_screen.dart';
import 'package:servicemen_customer_app/views/bookings/cancelled_booking_screen.dart';

import '../../providers/booking_provider.dart';
import 'completed_booking_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}
class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final initialIndex =
        context.read<BookingProvider>().tabIndex;

    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: initialIndex,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context
            .read<BookingProvider>()
            .changeTab(_tabController.index);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    final tabIndex =
    context.select<BookingProvider, int>(
          (p) => p.tabIndex,
    );

    // keep TabController in sync if provider changes tab
    if (_tabController.index != tabIndex) {
      _tabController.animateTo(tabIndex);
    }

    return Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.kPrimaryColor,
            labelColor:AppColors.kPrimaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.grey,
              labelStyle:AppTextStyles.sf16kPrimaryColorMediumTextStyle,
            unselectedLabelStyle:AppTextStyles.sf16kGreyW400TextStyle ,
            tabs:  [
              Tab(text: context.l10n.active),
              Tab(text: context.l10n.completed),
              Tab(text: context.l10n.cancelled),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ActiveBookingScreen(),
                CompletedBookingScreen(),
                CancelledBookingScreen(),
              ],
            ),
          ),
        ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}



