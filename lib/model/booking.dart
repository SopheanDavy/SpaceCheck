// ignore_for_file: public_member_api_docs, sort_constructors_first
enum BookingStatus { active, cancelled, complete }

class Booking {
  String id;
  String UserId;
  String facilityId;
  DateTime startTime;
  DateTime endTime;
  
  Booking({
    required this.id,
    required this.UserId,
    required this.facilityId,
    required this.startTime,
    required this.endTime,
  });
}
