import 'package:test/test.dart';
import '../lib/model/user.dart';
import '../lib/model/facility.dart';
import '../lib/model/facility_status.dart';
import '../lib/services/occupancy_service.dart';

void main() {
  // Common objects we can use in our tests
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

  // 10:00 AM (during opening hours 6 to 22)
  final openTime = DateTime(2026, 3, 10, 10, 0);

  // TEST 1 — NORMAL CASE: Valid check-in increases occupancy
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

  // TEST 2 — BOUNDARY CASE: Last available seat makes facility Full
  test('Boundary: checking into the last seat changes status to full', () {
    // Hint:
    // 1. Create a gym with capacity: 1
    // 2. Check in sokha at openTime
    // 3. Call final status = service.getFacilityStatus(gym, openTime);
    // 4. expect(status.availability, AvailabilityStatus.full);
  });

  // TEST 3 — INVALID CASE: Cannot check in when facility is full
  test('Invalid: checking in when facility is full throws ArgumentError', () {
    // Hint:
    // 1. Create a gym with capacity: 1
    // 2. Check in sokha first (now gym has 1/1 -> full!)
    // 3. Expect dara checking in to throw:
    //    expect(() => service.checkIn(dara, gym, [gym], openTime), throwsArgumentError);
  });

  // TEST 4 — INVALID CASE: Cannot check in when facility is closed
  test('Invalid: checking in outside opening hours throws ArgumentError', () {
    // Hint:
    // 1. Create a gym (openingHour: 6, closingHour: 22)
    // 2. Create a closedTime at 23:00 -> DateTime(2026, 3, 10, 23, 0)
    // 3. Expect sokha checking in at closedTime to throw throwsArgumentError
  });

  // TEST 5 — NORMAL CASE: Checking out decreases occupancy
  test('Normal: resident checking out reduces occupancy to 0', () {
    // Hint:
    // 1. Create a gym with capacity: 2
    // 2. Check in sokha at openTime
    // 3. Call service.checkOut(sokha, gym, DateTime(2026, 3, 10, 11, 0));
    // 4. expect(gym.currentOccupancy, 0);
  });
}