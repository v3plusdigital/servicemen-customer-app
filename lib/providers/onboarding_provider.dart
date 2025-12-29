import 'package:flutter/material.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';

import '../models/onboarding_model.dart';


class OnboardingProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  List<OnboardingModel> onboardingData = [];
  List<String> whyChooseServicemenList=[
    AppImages.verifiedIcon,
    AppImages.calendarIcon,
    AppImages.premiumIcon,
    AppImages.clockIcon
  ];



  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage(int totalPages) {
    if (_currentIndex < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  void skipToEnd(int totalPages) {
    pageController.animateToPage(
      totalPages - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
