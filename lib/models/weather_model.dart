//tutaj beda zawarte najwazniejsze informacje o pogodzie

class CurrentWeather {
  int weatherCode ;//stan pogody np. slonce, pada itp
  double temperature;
  bool? day; //dzień - true | noc - false
  //mozna dodac co sie chce w sumie

  CurrentWeather ({
    required this.weatherCode,
    required this.temperature,
    this.day
  });

  //konwertujemy plik json na dane
  factory CurrentWeather.fromJson(Map<String, dynamic> json,int hour) {
    return CurrentWeather(
      weatherCode: json['current']['weather_code'],
      temperature: json['current']['temperature_2m'],
      day: hour >= DateTime.parse(json['daily']['sunrise'][0]).hour && hour <= DateTime.parse(json['daily']['sunset'][0]).hour
    );
  }

}


class HourlyWeather extends CurrentWeather {
  int hour;

  HourlyWeather({
    required this.hour,
    required weatherCode,
    required temperature,
    required day,

  }) : super(weatherCode: weatherCode, temperature: temperature,day : day);

    //konwertujemy plik json na dane
  factory HourlyWeather.fromJson(Map<String, dynamic> json,int index) {
    return HourlyWeather(
      weatherCode: json['hourly']['weather_code'][index],
      temperature: json['hourly']['temperature_2m'][index],
      hour: index % 24,
      day: (index % 24) >= DateTime.parse(json['daily']['sunrise'][0]).hour && (index % 24) <= DateTime.parse(json['daily']['sunset'][0]).hour
    );
  }

}

class DailyWeather extends CurrentWeather {
  String dayOfWeek;
  double minTemperature;
  double maxTemperature;

  DailyWeather({
    required this.dayOfWeek,
    required this.minTemperature,
    required this.maxTemperature,
    required int weatherCode,
    required double temperature
  }) : super(weatherCode: weatherCode, temperature: temperature);

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
      temperature: (json['daily']['temperature_2m_max'][index] + json['daily']['temperature_2m_min'][index]) / 2, //srednia
    );
  }
}