import 'package:blabla/ui/screens/ride_pref/ride_prefs_screen.dart';
import 'package:flutter/material.dart';
import 'package:blabla/ui/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(body: RidePrefsScreen()),
    );
  }
}
