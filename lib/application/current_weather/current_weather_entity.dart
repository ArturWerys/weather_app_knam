import 'package:weatherapp/application/core/cloudiness_value_object.dart';
import 'package:weatherapp/application/core/humidity_value_object.dart';
import 'package:weatherapp/application/core/temperature_value_object.dart';
import 'package:weatherapp/application/core/time_value_object.dart';
import 'package:weatherapp/data/current/models/current.dart';
import 'package:weatherapp/application/core/wind_value_object.dart';

class CurrentWeatherEntity {
  final TemperatureValueObject temperatureC;
  final TemperatureValueObject temperatureF;
  final WindValueObject speedM;
  final WindValueObject speedKM;
  final HumidityValueObject hValue;
  final CloudinessValueObject cValue;
  final TimeValueObject time;

  CurrentWeatherEntity({
    required this.temperatureC,
    required this.temperatureF,
    required this.speedM,
    required this.speedKM,
    required this.hValue,
    required this.cValue,
    required this.time,
  });

  static CurrentWeatherEntity fromModel(Current model) {
    return CurrentWeatherEntity(
        temperatureC: TemperatureValueObject(
          unit: TemperatureUnit.celsius,
          value: model.current.temperatureCelsius,
        ),
        temperatureF: TemperatureValueObject(
          unit: TemperatureUnit.fahrenheit,
          value: model.current.temperatureFahrenheit,
        ),
        speedM: WindValueObject(
          unit: WindSpeedUnit.mile,
          value: model.current.windMph,
          direction: model.current.windDirection,
        ),
        speedKM: WindValueObject(
          unit: WindSpeedUnit.kilometr,
          value: model.current.windKph,
          direction: model.current.windDirection,
        ),
        hValue: HumidityValueObject(value: model.current.humidity),
        cValue: CloudinessValueObject(cValue: model.current.cloudiness),
        time: TimeValueObject(time: model.location.localTime));
  }
}
