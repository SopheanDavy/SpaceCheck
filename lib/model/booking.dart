enum BookingStatus { active, cancelled, complete }

class Booking {
  String id;
  String userId;
  String facilityId;
  DateTime startTime;
  DateTime endTime;
  
  Booking({
    required this.id,
    required this.userId,
    required this.facilityId,
    required this.startTime,
    required this.endTime,
  });
}
