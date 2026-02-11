import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/actions/blabutton.dart';
import 'package:flutter/material.dart';

class SeatBooking extends StatefulWidget {
  const SeatBooking({super.key, required this.numOfSeats});

  final int numOfSeats;

  @override
  State<SeatBooking> createState() => _SeatBookingState();
}

class _SeatBookingState extends State<SeatBooking> {
  late int _pickSeat;

  @override
  void initState() {
    super.initState();
    _pickSeat = widget.numOfSeats;
  }

  void onAdd() {
    setState(() {
      if (_pickSeat < 8) {
        _pickSeat++;
      }
    });
  }

  void onMinus() {
    setState(() {
      if (_pickSeat > 0) {
        _pickSeat--;
      }
    });
  }

  void onConfirm(int seats) {
    Navigator.pop(context, seats);
  }

  Color get getIconAddColor =>
      _pickSeat < 8 ? BlaColors.primary : BlaColors.disabled;
  Color get getIconMinusColor =>
      _pickSeat > 0 ? BlaColors.primary : BlaColors.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: SizedBox(
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: BlaColors.primary),
                  iconSize: 30,
                ),
              ),
            ),
            Text("Number of seats to book", style: BlaTextStyles.heading),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: onMinus,
                    icon: Icon(
                      Icons.remove_circle_outline_rounded,
                      color: getIconMinusColor,
                    ),
                    iconSize: 30,
                  ),
                  Text(
                    _pickSeat.toString(),
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: onAdd,
                    icon: Icon(
                      Icons.add_circle_outline_rounded,
                      color: getIconAddColor,
                    ),
                    iconSize: 30,
                  ),
                ],
              ),
            ),
            BlaButton(
              onPressed: () => onConfirm(_pickSeat),
              label: "Confirm",
              buttonType: ButtonType.primary,
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
