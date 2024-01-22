import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double ageInDays = 0.0;
  late int selectedYear = DateTime.now().year; // Initialize with a default value

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future<void> _showPicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedYear = pickedDate.year;
      });

      // Call calculatedAge after updating the state
      calculatedAge();
    }
  }

  void calculatedAge() {
    DateTime now = DateTime.now();
    DateTime birthDate = DateTime(selectedYear);

    Duration difference = now.difference(birthDate);

    setState(() {
      ageInDays = difference.inDays.toDouble();
    });
  }

  String getAgeString() {
    int years = (ageInDays / 365).floor();
    int remainingDays = (ageInDays % 365).floor();
    int hours = (ageInDays * 24).floor();
    int minutes = (ageInDays * 24 * 60).floor();

    return "Your Age is \n $years years,\n"
        " $remainingDays days,\n"
        " $hours hours, and $minutes minutes";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AGE CALCULATOR'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: _showPicker,
              child: Text(selectedYear != null
                  ? selectedYear.toString()
                  : 'Select the Year of Birth'),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
              getAgeString(),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
