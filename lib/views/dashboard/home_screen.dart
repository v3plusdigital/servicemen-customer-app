import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/providers/dashboard_provider.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';

import '../../custom_widgets/custom_appbar.dart';
import '../../providers/booking_provider.dart';
import '../../utils/build_extention.dart';
import '../bookings/booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<DashboardProvider>().addingChooseServiceList(context);
  }

  @override
  Widget build(BuildContext context) {
    return   buildView();
  }

  Widget buildView(){
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: buildBottomNav(context),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Selector<DashboardProvider, int>(
      selector: (_, p) => p.index,
      builder: (_, index, __) {
        switch (index) {
          case 0:
            return buildHome();
          case 1:
            return BookingScreen();
          case 2:
            return Container();
          default:
            return buildHome();
        }
      },
    );
  }

  Widget buildHome() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBanner(context),
            SizedBox(height: 20),
            buildRepairServices(context),
            Divider(color: AppColors.kGrey4, thickness: 10),
            SizedBox(height: 20),
            buildVideoPhotos(context),
            SizedBox(height: 20),
            buildWhyChoose(context),
          ],
        ),
      ),
    );
  }

  Widget buildBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 140,
            child: PageView.builder(
              onPageChanged: (i) =>
                  context.read<DashboardProvider>().changeBanner(i),
              itemBuilder: (_, i) {
                return AppImageWidget().customNetworkImage(
                  radius: 8,
                  image: AppImages.bannerPlaceholderImage,
                );
              },
              itemCount: 3,
            ),
          ),
          const SizedBox(height: 15),
          Selector<DashboardProvider, int>(
            selector: (_, p) => p.bannerIndex,
            builder: (_, index, __) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: i == index ? 20 : 8,
                    height: 9,
                    decoration: BoxDecoration(
                      color: i == index ? Colors.indigo : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildRepairServices(BuildContext context) {
    final items = [
      "AC Service & Repair",
      "TV Repair",
      "Washing Machine",
      "Fridge Repair",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.repairServices,
            style: AppTextStyles.sf20kBlackSemiboldTextStyle,
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (_, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.serviceProductsList);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.kGrey3, AppColors.kWhite],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    border: Border.all(color: AppColors.kGrey1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          items[i],
                          style: AppTextStyles.sf16kBlackW400TextStyle,
                        ),
                      ),
                      Align(
                        alignment: AlignmentGeometry.bottomRight,
                        child: AppImageWidget().customNetworkImage(
                          radius: 0,
                          image: AppImages.categoryPlaceholderImage,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget buildVideoPhotos(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.videosPhotos,
            style: AppTextStyles.sf20kBlackSemiboldTextStyle,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) => AppImageWidget().customNetworkImage(
                radius: 8,
                width: (context.width / 3) - 20,
                image: AppImages.photoPlaceholderImage,
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 15),
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWhyChoose(BuildContext context) {
    final provider = context.read<DashboardProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.whyChooseServicemen,
            style: AppTextStyles.sf20kBlackSemiboldTextStyle,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.kGrey1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.chooseServiceList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 10,
                childAspectRatio: 1.8,
              ),
              itemBuilder: (_, i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.kSkyLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(10),
                      child: AppImageWidget().svgImage(
                        imageName: provider.chooseServiceList[i].image,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      provider.chooseServiceList[i].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Selector<DashboardProvider, int>(
        selector: (_, p) => p.index,
        builder: (_, index, __) {
          return index == 0
              ? CustomAppBar(
                  context: context,
                  titleColumn: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            context.l10n.home,
                            style: AppTextStyles.sf14kBlackW600TextStyle,
                          ),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                      Text(
                        '403, Mariya Palace, Near chintamani jain',
                        style: AppTextStyles.sf12kGreyW400TextStyle,
                      ),
                    ],
                  ),
                  leadingWidget: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: AppImageWidget().svgImage(
                        imageName: AppImages.locationIcon,
                      ),
                    ),
                    onTap: () {},
                  ),
                  actionWidget: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.kGrey1),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: AppImageWidget().svgImage(
                            imageName: AppImages.cartIcon,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.cart);
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.kGrey1),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: AppImageWidget().svgImage(
                            imageName: AppImages.notificationIcon,
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                )
              : CustomAppBar(
                  context: context,
                  title: index == 1
                      ? context.l10n.booking
                      : context.l10n.account,
                  leading: false,
                );
        },
      ),
    );
  }

  Widget buildBottomNav(BuildContext context) {
    return Selector<DashboardProvider, int>(
      selector: (_, p) => p.index,
      builder: (_, index, __) {
        return BottomNavigationBar(
          currentIndex: index,
          backgroundColor: AppColors.kWhite,
          onTap: (i) => context.read<DashboardProvider>().changeIndex(i),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: context.l10n.home,
            ),
            BottomNavigationBarItem(
              icon: AppImageWidget().svgImage(imageName: AppImages.bookingIcon),
              label: context.l10n.booking,
              activeIcon: AppImageWidget().svgImage(
                imageName: AppImages.bookingIcon,
                color: AppColors.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: AppImageWidget().svgImage(
                imageName: AppImages.personIcon,
                height: 25,
                width: 25,
              ),
              label: context.l10n.account,
              activeIcon: AppImageWidget().svgImage(
                height: 25,
                width: 25,
                imageName: AppImages.personIcon,
                color: AppColors.kPrimaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
