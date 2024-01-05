import 'package:flutter/widgets.dart';
import 'package:weatherapp/application/core/temperature_value_object.dart';

class MaxTempLabel extends StatelessWidget {
  final TemperatureValueObject maxTemp;

  const MaxTempLabel({
    super.key,
    required this.maxTemp,
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
            '$maxTemp',
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
