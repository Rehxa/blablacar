import 'package:blabla/model/ride/locations.dart';

import '../data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> allRides = fakeRides;

  static List<Ride> filter({
    required int requestedSeats,
    required Location departureLocation,
  }) {
    return allRides.where((ride) {
      return ride.availableSeats >= requestedSeats &&
          ride.departureLocation == departureLocation;
    }).toList();
  }
}
