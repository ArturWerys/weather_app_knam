// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/application/core/cloudiness_value_object.dart';
import 'package:weatherapp/application/core/humidity_value_object.dart';
import 'package:weatherapp/application/core/temperature_value_object.dart';
import 'package:weatherapp/application/core/time_value_object.dart';
import 'package:weatherapp/application/current_weather/current_weather_bloc.dart';
import 'package:weatherapp/application/current_weather/current_weather_entity.dart';
import 'package:weatherapp/application/forecast_weather/forecast_weather_bloc.dart';
import 'package:weatherapp/application/forecast_weather/forecast_weather_entity.dart';
import 'package:weatherapp/data/core/weather_client.dart';
import 'package:weatherapp/data/current/current_weather_repository.dart';
import 'package:weatherapp/data/forecast/forecast_weather_repository.dart';
import 'package:weatherapp/presentation/common/cloudiness_widget.dart';
import 'package:weatherapp/presentation/common/humidity_widget.dart';
import 'package:weatherapp/presentation/common/max_temp_widget.dart';
import 'package:weatherapp/presentation/common/thermometer.dart';
import 'package:weatherapp/presentation/common/time_widget.dart';
import 'package:weatherapp/presentation/common/wind_widget.dart';
import 'package:weatherapp/application/core/wind_value_object.dart';
import 'package:weatherapp/presentation/common/colors.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        Provider<WeatherClient>(
          create: (context) => WeatherClient(),
        ),
        Provider<CurrentWeatherRepository>(
          create: (context) => CurrentWeatherRepository(
            client: context.read<WeatherClient>(),
          ),
        ),
        Provider<ForecastWeatherRepository>(
          create: (context) =>
              ForecastWeatherRepository(client: context.read<WeatherClient>()),
        ),
        Provider<ForecastWeatherBloc>(
          create: (context) => ForecastWeatherBloc(
            repository: context.read<ForecastWeatherRepository>(),
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  CurrentWeatherEntity? getWeather({required CurrentWeatherState from}) {
    final state = from;

    if (state is CurrentWeatherLoading) {
      return state.lastWeather;
    }

    if (state is CurrentWeatherLoaded) {
      return state.weather;
    }

    return null;
  }

  ForecastWeatherEntity? getForecast({required ForecastWeatherState from}) {
    final state = from;

    if (state is ForecastWeatherLoading) {
      return state.lastWeather;
    }

    if (state is ForecastWeatherLoaded) {
      return state.weather;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    Color colorGradient1 = MyCustomColors.gradient1Color;
    Color colorGradient2 = MyCustomColors.gradient2Color;

    return BlocProvider(
        create: (context) => CurrentWeatherBloc(
              repository: context.read<CurrentWeatherRepository>(),
              create: (forecastContext) => ForecastWeatherBloc(
                repository: forecastContext.read<ForecastWeatherRepository>(),
              ),
            ),
        child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
            builder: (context, state) {
          final weather = getWeather(from: state);

          return BlocBuilder<ForecastWeatherBloc, ForecastWeatherState>(
              builder: (forecastContext, forecastState) {
            // Tutaj możesz pobrać prognozę na podstawie stanu prognozy (forecastState)
            final forecast = getForecast(from: forecastState);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background4.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: textEditingController,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: colorGradient1),
                                      ),
                                    )),
                              ),
                              IconButton(
                                onPressed: () {
                                  final location = textEditingController.text;
                                  context.read<CurrentWeatherBloc>().add(
                                        QueryForLocationEvent(
                                            location: location),
                                      );
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                icon: const Icon(Icons.search),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 4),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [colorGradient1, colorGradient2],
                                ),
                              ),
                              child: TimeLabel(
                                  time: weather?.time ??
                                      const TimeValueObject(time: '12:00')),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Thermometer(
                            temperature: weather?.temperatureC ??
                                const TemperatureValueObject(
                                  value: 0,
                                  unit: TemperatureUnit.celsius,
                                ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 150,
                            width: 325,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 4),
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [colorGradient1, colorGradient2],
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      WindLabel(
                                        wind: weather?.speedKM ??
                                            const WindValueObject(
                                              value: 0,
                                              unit: WindSpeedUnit.kilometr,
                                              direction: 'none',
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      HumidityLabel(
                                        humidity: weather?.hValue ??
                                            const HumidityValueObject(value: 0),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CloudinessLabel(
                                        cloudiness: weather?.cValue ??
                                            const CloudinessValueObject(
                                                cValue: 0),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          MaxTempLabel(
                              maxTemp: forecast?.maxTempC ??
                                  const TemperatureValueObject(
                                      value: 0, unit: TemperatureUnit.celsius)),
                        ],
                      ),
                    ),
                    if (state is CurrentWeatherLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            );
          });
        }));
  }
}
