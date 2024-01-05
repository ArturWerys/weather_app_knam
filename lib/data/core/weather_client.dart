import 'package:http/http.dart';
import 'package:weatherapp/data/core/base_client.dart';
import 'package:weatherapp/data/core/weather_client_path.dart';
import 'package:weatherapp/data/current/models/current.dart';
import 'package:weatherapp/data/forecast/models/forecast_weather.dart';

class WeatherClient extends WABaseClient {
  Future<Current> getCurrent(String location) async {
    final response = await get(WeatherClientPath.current.getUri(location));
    return Current.fromJson(response.body);
  }

  Future<Forecast> getForecast(String location) async {
    final response = await get(WeatherClientPath.forecast.getUri(location));
    return Forecast.fromJson(response.body);
  }
}
