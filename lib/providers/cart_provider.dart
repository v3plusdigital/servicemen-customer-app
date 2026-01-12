import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:servicemen_customer_app/models/get_cart_model.dart';
import 'package:servicemen_customer_app/models/get_order_summary_model.dart';
import 'package:servicemen_customer_app/models/time_slot_model.dart';
import 'package:servicemen_customer_app/services/repositories/services_repository.dart';
import 'package:servicemen_customer_app/services/repositories/services_repository_impl.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, int> _quantities = {}; // serviceId -> qty
  int getQuantity(int serviceId) => _quantities[serviceId] ?? 0;
  String _selectedSlot = "";
  bool isLoading = false;
  String? errorMessage;
  List<String> timeSlotList = [
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 AM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
    "07:00 PM",
  ];
  final ServicesRepository serviceRepo = ServicesRepositoryImpl();
  GetCartModel? getCartModel;
  TimeSlotModel? _timeSlot;
  GetOrderSummaryModel? _getOrderSummaryModel;

  Map<int, int> get quantities => _quantities;
  String get selectedSlot => _selectedSlot;
  TimeSlotModel? get timeSlot => _timeSlot;
  GetOrderSummaryModel? get getOrderSummaryModel => _getOrderSummaryModel;

  List<Map<String, dynamic>> get cartItems {
    return _quantities.entries
        .map((entry) => {"service_id": entry.key, "quantity": entry.value})
        .toList();
  }

  void initializeValue(int serviceId, int qty) {
    _quantities[serviceId] = qty;
    notifyListeners();
    print("_quantities--->${_quantities.entries.toSet()}");
  }

  void add(int serviceId) {
    _quantities[serviceId] = getQuantity(serviceId) + 1;
    notifyListeners();
  }

  void remove(int serviceId) {
    final current = getQuantity(serviceId);
    if (current <= 1) {
      _quantities.remove(serviceId);
    } else {
      _quantities[serviceId] = current - 1;
    }
    notifyListeners();
  }

  void selectSlot(String val) {
    _selectedSlot = val;
    notifyListeners();
  }

  Future<void> addToCart(BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    Map<String, dynamic> requestBody = {"items": cartItems};

    final cancel = BotToast.showLoading();
    notifyListeners();
    try {
      final response = await serviceRepo.addToCart(requestBody);
      if (response.success) {
        BotToast.showText(text: "Added To Cart");
      } else {
        errorMessage = response.message;
        BotToast.showText(text: response.error?.message.toString() ?? "");
      }
    } catch (_) {
      errorMessage = "Something went wrong";
    } finally {
      isLoading = false;
      cancel();
      notifyListeners();
    }
  }

  Future<void> getCart(BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    getCartModel = null;
    final cancel = BotToast.showLoading();
    notifyListeners();
    try {
      final response = await serviceRepo.getCart();
      if (response.success) {
        getCartModel = GetCartModel.fromJson(response.data);
      } else {
        errorMessage = response.message;
        BotToast.showText(text: response.error?.message.toString() ?? "");
      }
    } catch (_) {
      errorMessage = "Something went wrong";
    } finally {
      isLoading = false;
      cancel();
      notifyListeners();
    }
  }

  Future<void> getTimeSlot(BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    getCartModel = null;
    final cancel = BotToast.showLoading();
    notifyListeners();
    try {
      final response = await serviceRepo.getTimeSlot();
      if (response.success) {
        _timeSlot = TimeSlotModel.fromJson(response.data);
      } else {
        errorMessage = response.message;
        BotToast.showText(text: response.error?.message.toString() ?? "");
      }
    } catch (_) {
      errorMessage = "Something went wrong";
    } finally {
      isLoading = false;
      cancel();
      notifyListeners();
    }
  }

  Future<void> getOrderSummary(BuildContext context, int cartId) async {
    isLoading = true;
    errorMessage = null;
    _getOrderSummaryModel = null;
    _quantities.clear();
    final cancel = BotToast.showLoading();
    notifyListeners();
    try {
      final response = await serviceRepo.getOrderSummary(cartId);
      if (response.success) {
        _getOrderSummaryModel = GetOrderSummaryModel.fromJson(response.data);

        if (_getOrderSummaryModel != null) {
          _getOrderSummaryModel?.data?.cart?.items?.forEach((a) {
            print("a-->${a.toJson()}");
            initializeValue(a.serviceId!, a.quantity!);
          });
        }
      } else {
        errorMessage = response.message;
        BotToast.showText(text: response.error?.message.toString() ?? "");
      }
    } catch (_) {
      errorMessage = "Something went wrong";
    } finally {
      isLoading = false;
      cancel();
      notifyListeners();
    }
  }

  Future<void> deleteCart(BuildContext context, int cartId) async {
    isLoading = true;
    errorMessage = null;
    final cancel = BotToast.showLoading();
    notifyListeners();
    try {
      final response = await serviceRepo.deleteCart(cartId);
      if (response.success) {
      } else {
        errorMessage = response.message;
        BotToast.showText(text: response.error?.message.toString() ?? "");
      }
    } catch (_) {
      errorMessage = "Something went wrong";
    } finally {
      isLoading = false;
      cancel();
      notifyListeners();
    }
  }
}
