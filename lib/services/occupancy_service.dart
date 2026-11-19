import '../model/facility.dart';
import '../model/facility_status.dart';
import '../model/user.dart';
import '../model/check_in.dart';

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

  // avoid double checkIn for one user(they forgot to check out )
  CheckIn? findActiveCheckIn(User user, List<Facility> allFacilities) {
    for (var facility in allFacilities) {
      for (var checkIn in facility.checkIns) {
        if (checkIn.userId == user.id && checkIn.isActive) {
          return checkIn;
        }
      }
    }
    return null;
  }

  // who,     where, and        when:
  CheckIn checkIn(
    User user,
    Facility facility,
    List<Facility> allFacilities,
    DateTime now,
  ) {
    if (user.role != UserRole.resident) {
      throw ArgumentError('Only resident can check in');
    }
    if (!facility.isOpenAt(now)) {
      throw ArgumentError("facility is closed");
    }
    if (facility.isFull) {
      throw ArgumentError("Facility is full");
    }
    if (findActiveCheckIn(user, allFacilities) != null) {
      throw ArgumentError("You already check in, please check out first");
    } //How many check-in records this facility already has
    final newcheckIn = CheckIn(
      id: 'C${facility.checkIns.length + 1}',
      userId: user.id,
      facilityId: facility.id,
      checkInAt: now,
    );

    //final newCheckIn = CheckIn(user, facility, allFacilities, now);
    facility.checkIns.add(newcheckIn);
    return newcheckIn;
  }

  CheckIn checkOut(User user, Facility facility, DateTime now) {
    for (var checkIn in facility.checkIns) {
      if (checkIn.userId == user.id && checkIn.isActive) {
        checkIn.complete(now);
        return checkIn;
      }
    }
    throw ArgumentError("You're not checked in to this facility ");
  }
}
