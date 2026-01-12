import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_button.dart';
import 'package:servicemen_customer_app/providers/auth_provider.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/views/auth/widgets/onboarding_item_widget.dart';

import '../../custom_widgets/worm_page_indicator.dart';
import '../../models/onboarding_model.dart';
import '../../providers/onboarding_provider.dart';
import '../../utils/app_images.dart';
import '../../utils/build_extention.dart';

/*class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      child: const _OnboardingView(),
    );
  }
}*/

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen();

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<OnboardingProvider>().onboardingData = [
      OnboardingModel(
        image: AppImages.onboarding1Image,
        title: context.l10n.allHomeServicesInOneApp,
        subtitle: context.l10n.acTvFridgeWashingMachineMore,
      ),
      OnboardingModel(
        image: AppImages.onboarding2Image,
        title: context.l10n.fastBookingQuickInvoices,
        subtitle:
            context.l10n.enjoyASmoothBookingExperienceWithEasyInvoiceDownloads,
      ),
      OnboardingModel(
        image: AppImages.onboarding3Image,
        title: context.l10n.verifiedSkilledTechnicians,
        subtitle: context.l10n.professionalsWithRatingsReviewsAndServiceHistory,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: const Color(0xFFF4F3FF),
      body: Consumer<OnboardingProvider>(
        builder: (_, p, __) => p.onboardingData.isNotEmpty
            ? Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppImages.onboardingBgImage,
                    fit: BoxFit.cover,
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      p.currentIndex != p.onboardingData.length - 1
                          ? Align(
                              alignment: Alignment.topRight,
                              child: CustomOutlineButton(
                                height: 38,
                                borderRadius: BorderRadius.circular(8),
                                child: Text(
                                  context.l10n.skip,
                                  style: AppTextStyles.sf14kGreyW400TextStyle,
                                ),
                                onPressed: () {
                                  p.skipToEnd(p.onboardingData.length);
                                },
                              ),
                            )
                          : Container(height: 45),
                      const SizedBox(height: 20),
                      Expanded(
                        child: PageView.builder(
                          controller: p.pageController,
                          itemCount: p.onboardingData.length,
                          onPageChanged: p.onPageChanged,
                          itemBuilder: (_, index) {
                            final item = p.onboardingData[index];
                            return OnboardingItem(
                              image: item.image,
                              title: item.title,
                              subtitle: item.subtitle,
                              active: index == p.currentIndex,
                            );
                          },
                        ),
                      ),
                      WormIndicator(
                        count: p.onboardingData.length,
                        current: p.currentIndex,
                      ),

                      const SizedBox(height: 30),

                      Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: CustomButton(
                          child: Text(
                            p.currentIndex == p.onboardingData.length - 1
                                ? context.l10n.start
                                : context.l10n.next,
                            style: AppTextStyles.sf16kWhiteMediumTextStyle,
                          ),
                          onPressed: () {
                            if (p.currentIndex == p.onboardingData.length - 1) {
                              context.read<AuthProvider>().setFirstLaunchFalse();

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.login,
                                (predicate) => false,
                              );
                              //           // TODO: navigate to login/home
                            } else {
                              p.nextPage(p.onboardingData.length);
                            }
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 24),
                      //   child: SizedBox(
                      //     width: double.infinity,
                      //     height: 48,
                      //     child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.indigo,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(12),
                      //         ),
                      //       ),
                      //       onPressed: () {
                      //         if (p.currentIndex == p.onboardingData.length - 1) {
                      //           // TODO: navigate to login/home
                      //         } else {
                      //           p.nextPage(p.onboardingData.length);
                      //         }
                      //       },
                      //       child: Text(
                      //         p.currentIndex == p.onboardingData.length - 1
                      //             ? context.l10n.start
                      //             : context.l10n.next,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            )
            : Container(),
      ),
    );
  }
}
