import 'package:weatherapp/application/core/temperature_value_object.dart';
import 'package:weatherapp/data/forecast/models/forecast_weather.dart';

class ForecastWeatherEntity {
  final TemperatureValueObject maxTempC;

  ForecastWeatherEntity({required this.maxTempC});

  static ForecastWeatherEntity fromModel(Forecast model) {
    return ForecastWeatherEntity(
      maxTempC: TemperatureValueObject(
          unit: TemperatureUnit.celsius, value: model.forecast.maxTempC),
    );
  }
}
