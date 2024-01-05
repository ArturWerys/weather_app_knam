import 'package:flutter/material.dart';
import 'package:weatherapp/application/core/time_value_object.dart';

// Do zegarka wyświetlającego czas po lokalizacji??

class TimeLabel extends StatelessWidget {
  final TimeValueObject time;

  const TimeLabel({
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Wycentrowanie w pionie
        crossAxisAlignment:
            CrossAxisAlignment.center, // Wycentrowanie w poziomie
        children: [
          Text(
            time.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
