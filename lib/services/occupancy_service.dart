import '../model/facility.dart';
import '../model/facility_status.dart';

class OccupancyService {
  FacilityStatus getFacilityStatus(Facility facility, DateTime now) {
    final occupancy = facility.currentOccupancy;

    int remaining = facility.capacity - occupancy;
    if (remaining < 0) {
      remaining = 0;
    }

    AvailabilityStatus status;
    if (!facility.isOpenAt(now)) {
      status = AvailabilityStatus.closed;
    } else if (facility.isFull) {
      status = AvailabilityStatus.full;
    } else if (occupancy >= facility.capacity * 0.7) {
      status = AvailabilityStatus.almostFull;
    } else {
      status = AvailabilityStatus.available;
    }

    return FacilityStatus(
      facilityId: facility.id,
      currentOccupancy: occupancy,
      capacity: facility.capacity,
      remainingSpaces: remaining,
      availability: status,
    );
  }
}
