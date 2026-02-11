import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  //
  //  filter the rides starting from given departure location
  //
  static List<Ride> _filterByDeparture(Location departure) {
    //   for (var rides in availableRides) {
    //     if (rides.departureLocation == departure) {
    //       filter.add(rides);
    //     }
    //   }

    List<Ride> filter = availableRides
        .where((d) => d.departureLocation == departure)
        .toList();
    return filter;
  }

  //
  //  filter the rides starting for the given requested seat number
  //
  static List<Ride> _filterBySeatRequested(int requestedSeat) {
    List<Ride> filter = availableRides
        .where((d) => d.availableSeats == requestedSeat)
        .toList();
    return filter;
  }

  //
  //  filter the rides   with several optional criteria (flexible filter options)
  //
  static List<Ride> filterBy({
    Location? departureLocation,
    int? requestedSeats,
  }) {
    List<Ride> filter = availableRides;
    if (departureLocation != null) {
      filter = _filterByDeparture(departureLocation);
    }

    if (requestedSeats != null) {
      filter = filter.where((d) => d.availableSeats >= requestedSeats).toList();
    }

    return filter;
  }
}
