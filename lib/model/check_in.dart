class CheckIn {
  String id;
  String userId;
  String facilityId;
  DateTime checkInAt;
  DateTime? checkOutAt;

  CheckIn({
    required this.id,
    required this.userId,
    required this.facilityId,
    required this.checkInAt,
    this.checkOutAt,
  });

  bool get isActive {
  if (checkOutAt == null) {
    return true;   // Still inside the room
  } else {
    return false;  // Already left the room
  }
}

  void complete(DateTime checkOutTime) {
    if (checkOutTime.isBefore(checkInAt)) {
      throw Exception("check out can not be before check in time.");
    }
    checkOutAt = checkOutTime;
  }
}
