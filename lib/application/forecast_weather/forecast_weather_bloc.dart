import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/application/forecast_weather/forecast_weather_entity.dart';
import 'package:weatherapp/data/forecast/forecast_weather_repository.dart';

class ForecastWeatherBloc
    extends Bloc<QueryForLocationEventForecast, ForecastWeatherState> {
  final ForecastWeatherRepository repository;

  ForecastWeatherBloc({required this.repository})
      : super(ForecastWeatherInitial()) {
    on<QueryForLocationEventForecast>((event, emit) async {
      final location = event.location;

      final state = this.state;
      if (state is ForecastWeatherLoaded) {
        emit(ForecastWeatherLoading(lastWeather: state.weather));
      } else {
        emit(ForecastWeatherLoading());
      }

      final weather = await repository.getWeather(location);

      if (weather != null) {
        final weatherEntity = ForecastWeatherEntity.fromModel(weather);

        emit(ForecastWeatherLoaded(weather: weatherEntity));
      } else {
        emit(ForecastWeatherInitial());
      }
    });
  }
}

sealed class ForecastWeatherState {}

class ForecastWeatherInitial extends ForecastWeatherState {}

class ForecastWeatherLoading extends ForecastWeatherState {
  final ForecastWeatherEntity? lastWeather;

  ForecastWeatherLoading({
    this.lastWeather,
  });
}

class ForecastWeatherLoaded extends ForecastWeatherState {
  final ForecastWeatherEntity weather;

  ForecastWeatherLoaded({
    required this.weather,
  });
}

class QueryForLocationEventForecast {
  final String location;

  QueryForLocationEventForecast({
    required this.location,
  });
}
