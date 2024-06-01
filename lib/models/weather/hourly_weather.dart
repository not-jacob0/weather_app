import 'package:weather_app/models/weather/weather_model.dart';

class HourlyWeather extends Weather {
  int hour;

  HourlyWeather({
    required this.hour,
    required int weatherCode,
    required double temperature,
    required bool day,
  }) : super(weatherCode: weatherCode, temperature: temperature, day: day);

  // Konwertujemy plik JSON na dane
  factory HourlyWeather.fromJson(Map<String, dynamic> json, int index) {
    return HourlyWeather(
      weatherCode: json['hourly']['weather_code'][index],
      temperature: json['hourly']['temperature_2m'][index],
      hour: index % 24,
      day: (index % 24) >= DateTime.parse(json['daily']['sunrise'][0]).hour &&
           (index % 24) <= DateTime.parse(json['daily']['sunset'][0]).hour,
    );
  }
}