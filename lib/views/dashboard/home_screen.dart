import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/models/get_profile_model.dart';
import 'package:servicemen_customer_app/providers/cart_provider.dart';
import 'package:servicemen_customer_app/providers/dashboard_provider.dart';
import 'package:servicemen_customer_app/providers/location_provider.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/views/account/account_screen.dart';

import '../../custom_widgets/custom_appbar.dart';
import '../../models/choose_servicemen_model.dart';
import '../../models/dashboard_response_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/booking_provider.dart';
import '../../utils/build_extention.dart';
import '../bookings/booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _calledOnce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_calledOnce) return; // 🔥 STOP RE-CALLS
    _calledOnce = true;
    context.read<DashboardProvider>().changeIndex(0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Home screen calling-----");
      context.read<DashboardProvider>().addingChooseServiceList(context);
      context.read<DashboardProvider>().dashboard(context);
      context.read<AuthProvider>().getProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            return AccountScreen();
          default:
            return buildHome();
        }
      },
    );
  }

  Widget buildHome() {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<DashboardProvider>().addingChooseServiceList(context);
          await context.read<DashboardProvider>().dashboard(context);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // 🔥 REQUIRED
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            SliverToBoxAdapter(child: buildBanner(context)),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            SliverToBoxAdapter(child: buildRepairServices(context)),

            const SliverToBoxAdapter(
              child: Divider(color: AppColors.kGrey4, thickness: 10),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            SliverToBoxAdapter(child: buildVideoPhotos(context)),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            SliverToBoxAdapter(child: buildWhyChoose(context)),

            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }

  Widget buildBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Selector<DashboardProvider, DashboardResponseModel?>(
        selector: (_, p) => p.dashboardResponseModel,
        builder: (_, dashboardResponseModel, __) {
          return Column(
            children: [
              SizedBox(
                height: 180,
                child: PageView.builder(
                  onPageChanged: (i) =>
                      context.read<DashboardProvider>().changeBanner(i),
                  itemBuilder: (_, i) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: AppImageWidget().customNetworkImage(
                        radius: 10,

                        image:
                            dashboardResponseModel
                                ?.data
                                ?.offers?[i]
                                .thumbnail ??
                            "",
                      ),
                      // Image.asset(
                      //   AppImages.bannerPlaceholderImage,
                      //   fit: BoxFit.cover,
                      //   filterQuality: FilterQuality.high,
                      // )
                    );
                    return AppImageWidget().customNetworkImage(
                      radius: 8,
                      boxFitVal: BoxFit.contain,
                      alignment: Alignment.center,
                      image: AppImages.bannerPlaceholderImage,
                    );
                  },
                  itemCount: dashboardResponseModel?.data?.offers?.length ?? 0,
                ),
              ),
              const SizedBox(height: 15),
              Selector<DashboardProvider, int>(
                selector: (_, p) => p.bannerIndex,
                builder: (_, index, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      dashboardResponseModel?.data?.offers?.length ?? 0,
                      (i) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: i == index ? 20 : 8,
                        height: 9,
                        decoration: BoxDecoration(
                          color: i == index
                              ? AppColors.kPrimaryColor
                              : AppColors.kGrey3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildRepairServices(BuildContext context) {
    return Selector<DashboardProvider, DashboardResponseModel?>(
      selector: (_, p) => p.dashboardResponseModel,
      builder: (_, dashboardResponseModel, __) {
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
              dashboardResponseModel != null
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          dashboardResponseModel.data?.serviceTypes?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1.5,
                          ),
                      itemBuilder: (_, i) {
                        ServiceTypeElement? service =
                            dashboardResponseModel.data?.serviceTypes![i];
                        return GestureDetector(
                          onTap: () async {
                            final provider = context.read<DashboardProvider>();
                            provider.selectServiceType(service.id!);
                            Navigator.pushNamed(
                              context,
                              AppRoutes.serviceProductsList,
                              arguments: context.read<DashboardProvider>(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 8,
                              top: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.kGrey3, AppColors.kWhite],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              border: Border.all(color: AppColors.kGrey1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  service!.name.toString(),
                                  maxLines: 2,
                                  style: AppTextStyles.sf16kBlackW400TextStyle,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentGeometry.bottomRight,
                                    child: AppImageWidget().customNetworkImage(
                                      radius: 0,
                                      image: service.image.toString(),
                                      width: 60,
                                      height: 60,
                                      boxFit: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
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
            height: 240,
            child: Selector<DashboardProvider, DashboardResponseModel?>(
              selector: (_, p) => p.dashboardResponseModel,
              builder: (_, dashboardResponseModel, __) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) =>
                      dashboardResponseModel
                              ?.data!
                              .mediaGallery![i]
                              .thumbnail ==
                          null
                      ? Container(
                          width: (context.width / 3) - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.kGrey1,
                          ),
                        )
                      : AspectRatio(
                          aspectRatio: 9 / 16,
                          child: AppImageWidget().customNetworkImage(
                            radius: 8,

                            width: (context.width / 3) - 20,
                            image:
                                dashboardResponseModel!
                                    .data!
                                    .mediaGallery![i]
                                    .thumbnail ??
                                "",
                          ),
                        ),
                  separatorBuilder: (_, __) => const SizedBox(width: 15),
                  itemCount:
                      dashboardResponseModel?.data?.mediaGallery?.length ?? 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWhyChoose(BuildContext context) {
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
          Selector<DashboardProvider, List<ChooseServicemenModel>>(
            selector: (_, p) => p.chooseServiceList,
            builder: (_, chooseServiceList, __) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kGrey1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: chooseServiceList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.4,
                    // childAspectRatio: 1.8,
                  ),
                  itemBuilder: (_, i) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.center,
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
                            imageName: chooseServiceList[i].image,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          chooseServiceList[i].title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
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
                  titleColumn: Selector<AuthProvider, GetProfileResponseModel?>(
                    selector: (_, p) => p.getProfileResponseModel,
                    builder: (_, p, __) {
                      if (p?.data?.addresses?.isNotEmpty ?? false) {
                        Address? address = p?.data?.addresses?.firstWhere(
                          (e) => e.isDefault == true,
                        );
                        return GestureDetector(
                          onTap: () async {
                            final provider = context.read<LocationProvider>();
                            final cancel = BotToast.showLoading();

                            final successVal = await provider.getAddressList();

                            cancel(); // ALWAYS close loading
                            print("successVal--->$successVal");
                            if (successVal == true) {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.addressList,
                              );
                            } else {
                              BotToast.showText(
                                text: provider.errorMessage ?? "Error",
                              );
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    address!.addressType.toString() ??
                                        context.l10n.home,
                                    style:
                                        AppTextStyles.sf14kBlackW600TextStyle,
                                  ),
                                  Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                              Text(
                                address.houseFlatNo != null
                                    ? "${address.houseFlatNo}, ${address.buildingSocietyName}, ${address.landmark != null ? "${address.landmark}, " : ""} ${address.area}, ${address.city}, ${address.state}-${address.pincode}"
                                    : "",
                                style: AppTextStyles.sf12kGreyW400TextStyle,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            final provider = context.read<LocationProvider>();
                            final cancel = BotToast.showLoading();

                            final successVal = await provider.getAddressList();

                            cancel(); // ALWAYS close loading
                            print("successVal--->$successVal");
                            if (successVal == true) {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.addressList,
                              );
                            } else {
                              BotToast.showText(
                                text: provider.errorMessage ?? "Error",
                              );
                            }
                          },
                          child: Text(
                            context.l10n.addAddress,
                            style: AppTextStyles.sf14kBlackW600TextStyle,
                          ),
                        );
                      }
                    },
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
                          context
                              .read<CartProvider>()
                              .getCart(context)
                              .then(
                                (onValue) => Navigator.pushNamed(
                                  context,
                                  AppRoutes.cart,
                                ),
                              );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Selector<DashboardProvider, int>(
                      selector: (_, p) => p.unreadNotificationCount,
                      builder: (_, unreadCount, __) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
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
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.notifications,
                                  );
                                },
                              ),
                            ),
                            if (unreadCount > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.kRed,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Center(
                                    child: Text(
                                      unreadCount > 99 ? '99+' : '$unreadCount',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
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
              icon: AppImageWidget().svgImage(
                imageName: AppImages.homeIcon,
                color: AppColors.kGrey,
              ),
              label: context.l10n.home,
              activeIcon: AppImageWidget().svgImage(
                imageName: AppImages.homeIcon,
                color: AppColors.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: AppImageWidget().svgImage(
                imageName: AppImages.bookingIcon,
                color: AppColors.kGrey,
              ),
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
                color: AppColors.kGrey,
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
