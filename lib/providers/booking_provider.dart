import 'package:flutter/material.dart';

import '../models/booking_view_model.dart';

class BookingProvider extends ChangeNotifier {
  int _tabIndex = 0;
  Booking? selectedBooking;

  int get tabIndex => _tabIndex;

  List<Booking> get filteredBookings =>
      _bookings.where((b) => b.status == _selectedTab).toList();

  List<Booking> get bookings => _bookings;

  Booking? get booking => selectedBooking;
  BookingTabStatus _selectedTab = BookingTabStatus.active;

  void changeTab(int index) {
    if (_tabIndex == index) return;
    _tabIndex = index;
    if (index == 0) {
      _selectedTab = BookingTabStatus.active;
    } else if (index == 1) {
      _selectedTab = BookingTabStatus.completed;
    } else {
      _selectedTab = BookingTabStatus.cancelled;
    }
    notifyListeners();
  }

  final List<Booking> _bookings = [
    Booking(
      id: "#ORD-20241",
      title: "AC Service & Repair",
      service: "2 x Foam Service , 3 x Gas Refill",
      slotDate: DateTime(2025, 12, 2),
      slotTime: "12:00 PM",
      statusLabel: "Pending",
      completedDate: DateTime.now(),
      cancelledDate: DateTime.now(),
      amount: 0,
      refundAmount: 0,
      status: BookingTabStatus.active,
      bookingStatus: BookingStatus.pending,
    ),
    Booking(
      id: "#ORD-00456",
      title: "Washing Machine Repair",
      service: "Front Loaded",
      slotDate: DateTime(2025, 11, 28),
      slotTime: "05:00 PM",
      statusLabel: "Assigned",
      completedDate: DateTime.now(),
      cancelledDate: DateTime.now(),
      amount: 0,
      refundAmount: 0,
      status: BookingTabStatus.active,
      bookingStatus: BookingStatus.pending,
    ),
    Booking(
      id: "#ORD-55889",
      title: "TV Repair",
      service: "LED Screen Repair",
      slotDate: DateTime(2025, 11, 26),
      slotTime: "02:00 PM",
      statusLabel: "In-Progress",
      completedDate: DateTime.now(),
      cancelledDate: DateTime.now(),
      amount: 0,
      refundAmount: 0,
      status: BookingTabStatus.active,
      bookingStatus: BookingStatus.inProgress,
    ),
    Booking(
      id: "#ORD-55889",
      title: "TV Repair",
      service: "LED Screen Repair",
      slotDate: DateTime(2025, 11, 26),
      slotTime: "02:00 PM",
      statusLabel: "Completed",
      completedDate: DateTime.now(),
      cancelledDate: DateTime.now(),
      amount: 0,
      refundAmount: 0,
      status: BookingTabStatus.completed,
      bookingStatus: BookingStatus.assigned,
    ),
    Booking(
      id: "#ORD-55889",
      title: "TV Repair",
      service: "LED Screen Repair",
      slotDate: DateTime(2025, 11, 26),
      slotTime: "02:00 PM",
      statusLabel: "Cancelled",
      amount: 340,
      refundAmount: 300,
      cancelledDate: DateTime.now(),
      completedDate: DateTime.now(),
      status: BookingTabStatus.cancelled,
      bookingStatus: BookingStatus.cancelled,
    ),
  ];

  void selectBooking(Booking booking) {
    selectedBooking = booking;
    notifyListeners();
  }
}
