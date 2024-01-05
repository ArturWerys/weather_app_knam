import 'package:flutter/material.dart';
import 'package:weatherapp/application/core/wind_value_object.dart';

class WindLabel extends StatelessWidget {
  final WindValueObject wind;

  const WindLabel({
    super.key,
    required this.wind,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Wycentrowanie elementów w pionie
        crossAxisAlignment:
            CrossAxisAlignment.center, // Wycentrowanie elementów w poziomie
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
              'assets/wind-blow.png',
              fit: BoxFit.contain,
            ),
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Wycentrowanie elementów w poziomie
            crossAxisAlignment:
                CrossAxisAlignment.center, // Wycentrowanie elementów w pionie
            children: [
              Text(
                wind.value.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                wind.unit.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // Text(
          //   wind.direction.toString(),
          //   style: const TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 15,
          //   ),
          // ),
        ],
      ),
    );
  }
}
