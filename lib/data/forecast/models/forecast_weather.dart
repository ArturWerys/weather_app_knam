import 'dart:convert';

import 'package:weatherapp/data/current/models/location.dart';
import 'package:weatherapp/data/forecast/models/forecast_weather_model.dart';

class Forecast {
  final Location location;
  final ForecastWeatherModel forecast;

  Forecast({
    required this.location,
    required this.forecast,
  });

  Forecast copyWith({
    Location? location,
    ForecastWeatherModel? forecast,
  }) {
    return Forecast(
      location: location ?? this.location,
      forecast: forecast ?? this.forecast,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location.toMap(),
      'current': forecast.toMap(),
    };
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      location: Location.fromMap(map['location']),
      forecast: ForecastWeatherModel.fromMap(map['forecast']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Forecast.fromJson(String source) =>
      Forecast.fromMap(json.decode(source));

  @override
  String toString() => 'Current(location: $location, current: $forecast)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Forecast &&
        other.location == location &&
        other.forecast == forecast;
  }

  @override
  int get hashCode => location.hashCode ^ forecast.hashCode;
}
