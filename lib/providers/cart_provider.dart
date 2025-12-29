import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, int> _quantities = {}; // serviceId -> qty
  int getQuantity(int serviceId) => _quantities[serviceId] ?? 0;
  String _selectedSlot="";
  List<String> timeSlotList=[
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

  Map<int, int> get quantities=>_quantities;
  String get selectedSlot=>_selectedSlot;


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

 void selectSlot(String val){
   _selectedSlot=val;
    notifyListeners();
  }
}
