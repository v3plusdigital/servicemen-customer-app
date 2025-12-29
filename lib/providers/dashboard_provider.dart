import 'package:flutter/material.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';

import '../models/choose_servicemen_model.dart';

class DashboardProvider extends ChangeNotifier{
  // String _selectedAddress =
  //     "403, Mariya Palace, Near chintamani jain...";

  List<ChooseServicemenModel> chooseServiceList=[];
  int _bannerIndex = 0;

  // String get selectedAddress => _selectedAddress;
  int get bannerIndex => _bannerIndex;

  // void changeAddress(String address) {
  //   _selectedAddress = address;
  //   notifyListeners();
  // }

  int _index = 0;

  int get index => _index;

  void changeIndex(int newIndex) {
    if (_index == newIndex) return;
    _index = newIndex;
    notifyListeners();
  }

  void changeBanner(int index) {
    _bannerIndex = index;
    notifyListeners();
  }

 void addingChooseServiceList(BuildContext context){
   chooseServiceList.addAll([
     ChooseServicemenModel(image: AppImages.verifiedIcon, title: context.l10n.expertVerifiedTechnicians),
     ChooseServicemenModel(image: AppImages.calendarIcon, title: context.l10n.quickEasyBooking),
     ChooseServicemenModel(image: AppImages.premiumIcon, title: context.l10n.affordableTransparentPricing),
     ChooseServicemenModel(image: AppImages.clockIcon, title: context.l10n.onTimeServiceGuarantee),
   ]);
  }
}