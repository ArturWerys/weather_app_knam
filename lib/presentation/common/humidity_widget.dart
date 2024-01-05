import 'package:flutter/material.dart';
import 'package:weatherapp/application/core/humidity_value_object.dart';

class HumidityLabel extends StatelessWidget {
  final HumidityValueObject humidity;

  const HumidityLabel({
    super.key,
    required this.humidity,
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
          Image.asset(
            'assets/humidity.png',
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 2),
          Text(
            '${humidity.value} %',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            textAlign: TextAlign.center, // Wycentrowanie tekstu
          ),
        ],
      ),
    );
  }
}
