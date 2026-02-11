import 'package:blabla/ui/screens/ride_pref/widgets/blabutton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TestScreen()));
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BlaButton(
              onPressed: () {},
              label: "Contact Volodia",
              buttonType: ButtonType.secondary,
              iconData: Icons.chat_rounded,
            ),
            const SizedBox(height: 20),
            BlaButton(
              onPressed: () {},
              label: "Request to book",
              buttonType: ButtonType.primary,
              iconData: Icons.calendar_month_sharp,
            ),
          ],
        ),
      ),
    );
  }
}
