enum BookingStatus { pending, accepted, rejected }

class Booking {
  final String id;
  final String title;
  BookingStatus status;

  Booking({
    required this.id,
    required this.title,
    this.status = BookingStatus.pending,
  });
}
