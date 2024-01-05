import 'package:weatherapp/data/core/weather_client.dart';
import 'package:weatherapp/data/forecast/models/forecast_weather.dart';

class ForecastWeatherRepository {
  final WeatherClient client;

  ForecastWeatherRepository({required this.client});
  Future<Forecast?> getWeather(String location) async {
    try {
      final modelForecast = await client.getForecast(location);

      return modelForecast;
    } catch (e) {
      print('EXCEPTION: $e');
    }
    return null;
  }
}
