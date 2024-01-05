enum WeatherClientPath {
  current,
  forecast,
  history;

  const WeatherClientPath();

  String get path {
    switch (this) {
      case WeatherClientPath.current:
        return '/v1/current.json';
      case WeatherClientPath.forecast:
        return '/v1/forecast.json';
      case WeatherClientPath.history:
        return '/v1/history.json';
    }
  }

  Uri get baseUri => Uri.https(
        'api.weatherapi.com',
        '',
        <String, dynamic>{
          'key': '7ed7efaaad464c5eb7a132126240101',
          'aqi': 'no',
        },
      );

  Uri getUri([String? query]) {
    if (query == null) {
      return Uri.https(
        baseUri.authority,
        path,
        baseUri.queryParameters,
      );
    }

    return Uri.https(
      baseUri.authority,
      WeatherClientPath.current.path,
      <String, dynamic>{...baseUri.queryParameters, 'q': query},
    );
  }
}
