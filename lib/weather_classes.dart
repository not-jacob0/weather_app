class WeatherData {
  int temperature;
  String description;
  //inne dane

  WeatherData({required this.temperature,required this.description});
}

class HourlyWeather extends WeatherData {
  int hour;

  HourlyWeather({
    required this.hour,
    required int temperature,
    required String description,
  }) : super(temperature: temperature, description: description);
}

class DailyWeather extends WeatherData {
  String date;

  DailyWeather({
    required this.date,
    required int temperature,
    required String description,
  }) : super(temperature: temperature, description: description);
}