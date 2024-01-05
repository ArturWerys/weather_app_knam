import 'package:flutter/material.dart';
import 'package:weatherapp/application/core/temperature_value_object.dart';
import 'package:weatherapp/presentation/common/gradient_extension.dart';

class Thermometer extends StatelessWidget {
  final TemperatureValueObject temperature;

  const Thermometer({
    super.key,
    required this.temperature,
  });

  static const TemperatureValueObject _minTemperature = TemperatureValueObject(
    value: -30,
    unit: TemperatureUnit.celsius,
  );

  static const TemperatureValueObject _maxTemperature = TemperatureValueObject(
    value: 36,
    unit: TemperatureUnit.celsius,
  );

  static const LinearGradient _colorGradient = LinearGradient(
    stops: [
      0.1,
      0.2,
      0.4,
      0.6,
      0.9,
    ],
    colors: [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.lightBlue,
      Colors.blue,
    ],
  );

  Color _getColor(TemperatureValueObject temperature) {
    final value = temperature.value;
    final minValue = _minTemperature.value;
    final maxValue = _maxTemperature.value;
    final range = maxValue - minValue;

    return _colorGradient.colorAt(
      (maxValue - value) / range,
    )!;
  }

  double _getHeightFactor(TemperatureValueObject temperature) {
    final value = temperature.value;
    final minValue = _minTemperature.value;
    final maxValue = _maxTemperature.value;
    final range = maxValue - minValue;

    return 1 - (maxValue - value) / range;
  }

  @override
  Widget build(BuildContext context) {
    final heightFactor = _getHeightFactor(temperature);
    final color = _getColor(temperature);

    return Center(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 350,
            child: AnimatedContainer(
              clipBehavior: Clip.none,
              height: (heightFactor * 350).clamp(50, 350),
              alignment: Alignment.topCenter,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: TemperatureLabel(temperature: temperature),
            ),
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedContainer(
                  width: 80,
                  height: heightFactor * 350,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: const ShapeDecoration(
                    color: Colors.transparent,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.white,
                        // color: Color(0xFF1D3C5D),
                        width: 4,
                      ),
                    ),
                  ),
                  width: 80,
                  height: 350,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TemperatureLabel extends StatelessWidget {
  final TemperatureValueObject temperature;

  const TemperatureLabel({
    super.key,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Text(
            temperature.value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            temperature.unit.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
