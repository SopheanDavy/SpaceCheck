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

  bool get isActive => checkOutAt == null;

  void complete(DateTime checkOutTime) {
    if (checkOutTime.isBefore(checkInAt)) {
      throw Exception("check out can not be before check in time.");
    }
    checkOutAt = checkOutTime;
  }
}
