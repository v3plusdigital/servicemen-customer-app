import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:servicemen_customer_app/models/dashboard_response_model.dart';
import 'package:servicemen_customer_app/models/services_response_model.dart';
import 'package:servicemen_customer_app/services/repositories/services_repository.dart';
import 'package:servicemen_customer_app/services/repositories/services_repository_impl.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';

import '../models/choose_servicemen_model.dart';
import '../models/notification_model.dart';
import '../services/local_data/shared_pref.dart';
import '../services/local_data/shared_pref_keys.dart';

class DashboardProvider extends ChangeNotifier {
  // String _selectedAddress =
  //     "403, Mariya Palace, Near chintamani jain...";

  List<ChooseServicemenModel> chooseServiceList = [];
  int _bannerIndex = 0;

  int? selectedServiceType;

  // String get selectedAddress => _selectedAddress;
  int get bannerIndex => _bannerIndex;
  bool isLoading = false;
  String? errorMessage;
  DashboardResponseModel? _dashboardResponseModel;
  ServicesResponseModel? _servicesResponseModel;
  final ServicesRepository serviceRepo = ServicesRepositoryImpl();
  List<NotificationModel> _notifications = [];

  // void changeAddress(String address) {
  //   _selectedAddress = address;
  //   notifyListeners();
  // }

  int _index = 0;

  int get index => _index;

  DashboardResponseModel? get dashboardResponseModel => _dashboardResponseModel;

  ServicesResponseModel? get servicesResponseModel => _servicesResponseModel;

  List<NotificationModel> get notifications => _notifications;

  int get unreadNotificationCount =>
      _notifications.where((n) => !n.isRead).length;

  void changeIndex(int newIndex) {
    if (_index == newIndex) return;
    _index = newIndex;
    notifyListeners();
  }

  void changeBanner(int index) {
    _bannerIndex = index;
    notifyListeners();
  }

  void addingChooseServiceList(BuildContext context) {
    chooseServiceList=[
      ChooseServicemenModel(
        image: AppImages.verifiedIcon,
        title: context.l10n.expertVerifiedTechnicians,
      ),
      ChooseServicemenModel(
        image: AppImages.calendarIcon,
        title: context.l10n.quickEasyBooking,
      ),
      ChooseServicemenModel(
        image: AppImages.premiumIcon,
        title: context.l10n.affordableTransparentPricing,
      ),
      ChooseServicemenModel(
        image: AppImages.clockIcon,
        title: context.l10n.onTimeServiceGuarantee,
      ),
    ];

    notifyListeners();
  }

  void selectServiceType(int id)  {
    selectedServiceType = id;
    notifyListeners();
    getServiceByType();
  }

  Future<void> dashboard(BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    _dashboardResponseModel = null;
    final cancel = BotToast.showLoading();
    notifyListeners();
    try {
      final response = await serviceRepo.dashboard();

      if (response.success) {
        _dashboardResponseModel = DashboardResponseModel.fromJson(
          response.data,
        );
      } else {
        errorMessage = response.message;
      }
    } catch (_) {
      errorMessage = "Something went wrong";
    } finally {
      isLoading = false;
      cancel();
      notifyListeners();
    }
  }

  Future<void> getServiceByType() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    final cancel = BotToast.showLoading();
    try {
      final response = await serviceRepo.serviceByType(selectedServiceType!);

      if (response.success) {
        _servicesResponseModel = ServicesResponseModel.fromJson(response.data);
      }
    } catch (e) {
      print("error--$e");
    } finally {
      isLoading = false;
      cancel();
      notifyListeners();
    }
  }

  // Notification methods
  void loadNotifications() {
    // TODO: Replace with actual API call
    _notifications = [
      NotificationModel(
        title: 'Booking Confirmed',
        subtitle: 'Your AC repair service has been confirmed for 2nd Jan 2026',
        dateTime: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      NotificationModel(
        title: 'Service Completed',
        subtitle: 'Your washing machine service has been completed successfully',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        isRead: false,
      ),
      NotificationModel(
        title: 'Special Offer',
        subtitle: 'Get 20% off on your next refrigerator service',
        dateTime: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationModel(
        title: 'Payment Successful',
        subtitle: 'Payment of ₹500 received for booking #12345',
        dateTime: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
      ),
    ];
    notifyListeners();
  }

  void markNotificationAsRead(int index) {
    if (index >= 0 && index < _notifications.length) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllNotificationsAsRead() {
    _notifications = _notifications
        .map((notification) => notification.copyWith(isRead: true))
        .toList();
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
