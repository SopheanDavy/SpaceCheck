enum AvailabilityStatus { available, almostFull, full, closed }

class FacilityStatus {
  final String facilityId;
  final int currentOccupancy;
  final int capacity;
  final int remainingSpaces;
  final AvailabilityStatus availability;
  
  FacilityStatus({
    required this.facilityId,
    required this.currentOccupancy,
    required this.capacity,
    required this.remainingSpaces,
    required this.availability,
  });

  
}
