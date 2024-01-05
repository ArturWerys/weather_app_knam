import 'package:weatherapp/data/core/weather_client.dart';
import 'package:weatherapp/data/current/models/current.dart';

class CurrentWeatherRepository {
  final WeatherClient client;

  CurrentWeatherRepository({
    required this.client,
  });

  Future<Current?> getWeather(String location) async {
    try {
      final model = await client.getCurrent(location);

      return model;
    } catch (e) {
      print('EXCEPTION: $e');
    }
    return null;
  }
}
