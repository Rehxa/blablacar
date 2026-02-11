import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/service/rides_service.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class RideScreen extends StatelessWidget {
  const RideScreen({super.key, required this.ridePref});

  final RidePref ridePref;

  @override
  Widget build(BuildContext context) {
    List<Ride> filterRide = RidesService.filterBy(
      departureLocation: ridePref.departure,
      requestedSeats: ridePref.requestedSeats,
    );
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: filterRide.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: BlaColors.backgroundAccent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${filterRide[index].departureLocation}"),
                      Text("${filterRide[index].departureDate}"),
                      Text("${filterRide[index].arrivalLocation}"),
                      Text("${filterRide[index].arrivalDateTime}"),
                      Text("${filterRide[index].availableSeats}"),
                      Text("${filterRide[index].pricePerSeat}"),
                      Text("${filterRide[index].status}"),
                      Text("${filterRide[index].passengers}"),
                      Text("${filterRide[index].driver}"),
                      Text("${filterRide[index].remainingSeats}"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
