import 'package:flutter/material.dart';
import 'package:weatherapp/application/core/cloudiness_value_object.dart';

class CloudinessLabel extends StatelessWidget {
  final CloudinessValueObject cloudiness;

  const CloudinessLabel({
    super.key,
    required this.cloudiness,
  });

  @override
  Widget build(BuildContext context) {
    String cloudImage;
    String cloudString;
    if (cloudiness.cValue < 25) {
      cloudImage = 'assets/4sun.png';
      cloudString = 'Sunny';
    } else if (25 <= cloudiness.cValue && cloudiness.cValue < 50) {
      cloudImage = 'assets/3cloudSun.png';
      cloudString = 'Mostly Sunny';
    } else if (50 <= cloudiness.cValue && cloudiness.cValue < 75) {
      cloudImage = 'assets/2cloud.png';
      cloudString = 'Partly Cloudy';
    } else {
      cloudImage = 'assets/1cloudy.png';
      cloudString = 'Cloudy';
    }

    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Wycentrowanie w pionie
        crossAxisAlignment:
            CrossAxisAlignment.center, // Wycentrowanie w poziomie
        children: [
          Image.asset(
            cloudImage,
            height: 50,
            width: 50,
          ),
          Text(
            cloudString,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
