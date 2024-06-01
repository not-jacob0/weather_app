import 'package:weather_app/models/weather/weather_model.dart';

class DailyWeather extends Weather {
  String dayOfWeek;
  double minTemperature;
  double maxTemperature;

  DailyWeather({
    required this.dayOfWeek,
    required this.minTemperature,
    required this.maxTemperature,
    required int weatherCode,
    required double temperature,
    bool? day,
  }) : super(weatherCode: weatherCode, temperature: temperature, day: day);

  factory DailyWeather.fromJson(Map<String, dynamic> json, int index) {
    List<String> days = [
      "Poniedziałek",
      "Wtorek",
      "Środa",
      "Czwartek",
      "Piątek",
      "Sobota",
      "Niedziela"
    ];
    DateTime now = DateTime.now();
    int weekDay = (now.weekday - 1 + index) % 7;

    return DailyWeather(
      dayOfWeek: days[weekDay],
      minTemperature: json['daily']['temperature_2m_min'][index],
      maxTemperature: json['daily']['temperature_2m_max'][index],
      weatherCode: json['daily']['weather_code'][index],
      temperature: (json['daily']['temperature_2m_max'][index] +
              json['daily']['temperature_2m_min'][index]) /
          2, // średnia
      day: null, // wartość day jest tutaj nieistotna dla DailyWeather
    );
  }
}
