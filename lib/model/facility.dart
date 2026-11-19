import 'booking.dart';
import 'check_in.dart';

enum FacilityType { library, gym, badmintonCourt, swimmingPool }

class Facility {
  final String id;
  final String name;
  final FacilityType type;
  int capacity;
  int openingHour;
  int closingHour;
  final bool isBookable;
  final int unitCount;

  final List<CheckIn> checkIns;
  final List<Booking> bookings;

  Facility({
    required this.id,
    required this.name,
    required this.type,
    required this.capacity,
    required this.openingHour,
    required this.closingHour,

    this.isBookable = false,
    this.unitCount = 1,

    List<CheckIn>? checkIns,
    List<Booking>? bookings,

  }) : checkIns = checkIns ?? [], // allow passing existing lists from outside, this is Aggregation
      bookings = bookings ?? [];

  int get currentOccupancy {
    int count = 0;
    for (var checkIn in checkIns) {
      if (checkIn.isActive) {
        count++;
      }
    }
    return count;
  }
}
