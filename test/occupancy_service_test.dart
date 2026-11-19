import 'package:flutter_test/flutter_test.dart';
import '../lib/model/user.dart';
import '../lib/model/facility.dart';
import '../lib/model/facility_status.dart';
import '../lib/services/occupancy_service.dart';

void main() {
  final service = OccupancyService();

  final sokha = User(
    id: 'U1',
    name: 'Sokha',
    role: UserRole.resident,
  );

  final dara = User(
    id: 'U2',
    name: 'Dara',
    role: UserRole.resident,
  );

  final openTime = DateTime(2026, 3, 10, 10, 0);

  // Test 1: normal check-in increases occupancy
  test('Normal: resident can check in when facility is open and not full', () {
    final gym = Facility(
      id: 'F1',
      name: 'Gym',
      type: FacilityType.gym,
      capacity: 2,
      openingHour: 6,
      closingHour: 22,
    );

    service.checkIn(sokha, gym, [gym], openTime);

    expect(gym.currentOccupancy, 1);
  });

  // Test 2: last seat makes facility full
  test('Boundary: checking into the last seat changes status to full', () {
    final gym = Facility(
      id: 'F1',
      name: 'Gym',
      type: FacilityType.gym,
      capacity: 1,
      openingHour: 6,
      closingHour: 22,
    );

    service.checkIn(sokha, gym, [gym], openTime);
    final status = service.getFacilityStatus(gym, openTime);

    expect(status.availability, AvailabilityStatus.full);
  });

  // Test 3: cannot check in when full
  test('Invalid: checking in when facility is full throws ArgumentError', () {
    final gym = Facility(
      id: 'F1',
      name: 'Gym',
      type: FacilityType.gym,
      capacity: 1,
      openingHour: 6,
      closingHour: 22,
    );

    service.checkIn(sokha, gym, [gym], openTime);

    expect(() => service.checkIn(dara, gym, [gym], openTime), throwsArgumentError);
  });

  // Test 4: cannot check in when closed
  test('Invalid: checking in outside opening hours throws ArgumentError', () {
    final gym = Facility(
      id: 'F1',
      name: 'Gym',
      type: FacilityType.gym,
      capacity: 2,
      openingHour: 6,
      closingHour: 22,
    );

    final closedTime = DateTime(2026, 3, 10, 23, 0);

    expect(() => service.checkIn(sokha, gym, [gym], closedTime), throwsArgumentError);
  });

  // Test 5: check-out reduces occupancy back to 0
  test('Normal: resident checking out reduces occupancy to 0', () {
    final gym = Facility(
      id: 'F1',
      name: 'Gym',
      type: FacilityType.gym,
      capacity: 2,
      openingHour: 6,
      closingHour: 22,
    );

    service.checkIn(sokha, gym, [gym], openTime);
    service.checkOut(sokha, gym, DateTime(2026, 3, 10, 11, 0));

    expect(gym.currentOccupancy, 0);
  });
}