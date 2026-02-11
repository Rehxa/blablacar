import 'package:blabla/ui/screens/ride_pref/widgets/location_picker.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/ride_screen.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/seat_booking.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/actions/blabutton.dart';
import 'package:blabla/utils/animations_util.dart';
import 'package:blabla/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  final TextEditingController _requestedSeats = TextEditingController();

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    arrival = widget.initRidePref?.arrival;
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;

    _departureController.text = departure?.name ?? "";
    _arrivalController.text = arrival?.name ?? "";
    _requestedSeats.text = requestedSeats.toString();
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  @override
  void didUpdateWidget(covariant RidePrefForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initRidePref != oldWidget.initRidePref) {
      setState(() {
        departure = widget.initRidePref?.departure;
        departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
        arrival = widget.initRidePref?.arrival;
        requestedSeats = widget.initRidePref?.requestedSeats ?? 1;

        _departureController.text = departure?.name ?? "";
        _arrivalController.text = arrival?.name ?? "";
        _requestedSeats.text = requestedSeats.toString();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _departureController.dispose();
    _arrivalController.dispose();
    _requestedSeats.dispose();
  }

  void onSwap() {
    setState(() {
      final swap = departure;
      departure = arrival;
      arrival = swap;

      final String swapController = _departureController.text;
      _departureController.text = _arrivalController.text;
      _arrivalController.text = swapController;
    });
  }

  Future<void> onDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        departureDate = pickedDate;
      });
    }
  }

  void onSearch() {
    bool isSearch =
        departure != null &&
        arrival != null &&
        requestedSeats > 0 &&
        departure != arrival;

    if (isSearch) {
      RidePref newPref = RidePref(
        departure: departure!,
        departureDate: departureDate,
        arrival: arrival!,
        requestedSeats: requestedSeats,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RideScreen(ridePref: newPref)),
      );
    }
  }

  Future<void> onLocation(TextEditingController controller) async {
    final Location? searchLocation = await Navigator.push(
      context,
      AnimationUtils.createBottomToTopRoute<Location>(
        LocationPicker(locationSearch: controller.text),
      ),
    );
    if (searchLocation != null) {
      setState(() {
        controller.text = searchLocation.name;
      });
    }
  }

  Future<void> onSeat(TextEditingController controller) async {
    final int? numOfSeats = await Navigator.push(
      context,
      AnimationUtils.createBottomToTopRoute<int>(
        SeatBooking(numOfSeats: int.tryParse(controller.text)!),
      ),
    );
    if (numOfSeats != null) {
      setState(() {
        controller.text = numOfSeats.toString();
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get dateFormat => DateTimeUtils.formatDateTime(departureDate);

  bool get checkBothLocation =>
      _departureController.text != "" && _arrivalController.text != ""
      ? true
      : false;

  Color get textColor => widget.initRidePref != null
      ? BlaColors.neutralDark
      : BlaColors.neutralLight;

  Widget get iconButton => checkBothLocation
      ? IconButton(
          onPressed: onSwap,
          icon: Icon(Icons.swap_vert),
          color: BlaColors.primary,
        )
      : SizedBox.shrink();
  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                onTap: () => onLocation(_departureController),
                controller: _departureController,
                decoration: InputDecoration(
                  hintText: departure?.name ?? "Leaving from",
                  hintStyle: TextStyle(color: textColor),
                  icon: Icon(
                    Icons.circle_outlined,
                    color: BlaColors.neutralLight,
                  ),
                  suffixIcon: iconButton,
                ),
              ),
              TextFormField(
                readOnly: true,
                onTap: () => onLocation(_arrivalController),
                controller: _arrivalController,
                decoration: InputDecoration(
                  hintText: arrival?.name ?? "Going to",
                  hintStyle: TextStyle(color: textColor),
                  icon: Icon(
                    Icons.circle_outlined,
                    color: BlaColors.neutralLight,
                  ),
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: dateFormat),
                onTap: onDatePicker,
                decoration: InputDecoration(
                  hintText: dateFormat,
                  hintStyle: TextStyle(color: textColor),
                  icon: Icon(
                    Icons.calendar_month,
                    color: BlaColors.neutralLight,
                  ),
                ),
              ),
              TextFormField(
                readOnly: true,
                onTap: () => onSeat(_requestedSeats),
                controller: _requestedSeats,
                decoration: InputDecoration(
                  hintText: requestedSeats.toString(),
                  hintStyle: TextStyle(color: textColor),
                  icon: Icon(Icons.person, color: BlaColors.neutralLight),
                ),
              ),
            ],
          ),
        ),
        BlaButton(
          onPressed: onSearch,
          label: "Search",
          buttonType: ButtonType.primary,
        ),
      ],
    );
  }
}
