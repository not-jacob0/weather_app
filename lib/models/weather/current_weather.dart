import 'package:weather_app/models/weather/weather_model.dart';

class CurrentWeather extends Weather {
  int precipitation; // Szansa na opady
  double windSpeed;
  int cloudCover;

  CurrentWeather({
    required int weatherCode,
    required double temperature,
    required this.precipitation,
    required this.windSpeed,
    required this.cloudCover,
    bool? day,
  }) : super(weatherCode: weatherCode, temperature: temperature, day: day);

  // Konwertujemy plik JSON na dane
  factory CurrentWeather.fromJson(Map<String, dynamic> json, int hour) {
    return CurrentWeather(
        weatherCode: json['current']['weather_code'],
        temperature: json['current']['temperature_2m'],
        precipitation: json['current']['precipitation_probability'],
        windSpeed: json['current']['wind_speed_10m'],
        cloudCover: json['current']['cloud_cover'],
      day: hour >= DateTime.parse(json['daily']['sunrise'][0]).hour &&
           hour <= DateTime.parse(json['daily']['sunset'][0]).hour,
    );
  }
}