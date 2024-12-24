import 'package:flutter/material.dart';

enum BookingStatus { pending, accepted, rejected }

class Booking {
  final String id;
  final String name;
  final String location;
  BookingStatus status;

  Booking({
    required this.id,
    required this.name,
    required this.location,
    this.status = BookingStatus.pending,
  });
}

class BookingProvider with ChangeNotifier {
  final List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  void addBooking(String name, String location) {
    final newBooking = Booking(
      id: DateTime.now().toString(),
      name: name,
      location: location,
    );
    _bookings.add(newBooking);
    notifyListeners();
  }

  void updateBookingStatus(String id, BookingStatus status) {
    final booking = _bookings.firstWhere((booking) => booking.id == id);
    booking.status = status;
    notifyListeners();
  }
}
