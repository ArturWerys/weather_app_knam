import 'dart:convert';

class ForecastWeatherModel {
  final double maxTempC;

  ForecastWeatherModel({
    required this.maxTempC,
  });

  ForecastWeatherModel copyWith({
    double? maxTempC,
  }) {
    return ForecastWeatherModel(maxTempC: maxTempC ?? this.maxTempC);
  }

  Map<String, dynamic> toMap() {
    return {
      'maxtemp_c': maxTempC,
    };
  }

  factory ForecastWeatherModel.fromMap(Map<String, dynamic> map) {
    return ForecastWeatherModel(maxTempC: map['maxtemp_c']?.toDouble() ?? 0.0);
  }

  String toJson() => json.encode(toMap());

  factory ForecastWeatherModel.fromJson(String source) =>
      ForecastWeatherModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ForecastWeather( maxtemp_c: $maxTempC)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ForecastWeatherModel && other.maxTempC == maxTempC;
  }

  @override
  int get hashCode {
    return maxTempC.hashCode;
  }
}
