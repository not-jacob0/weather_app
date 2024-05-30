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
  String date;

  DailyWeather({
    required this.date,
    required weatherCode,
    required temperature
  }) : super(weatherCode: weatherCode, temperature: temperature);
}

//https://api.openweathermap.org/data/2.5/weather?q=Wroc%C5%82aw&appid=0943f00e7daf62d1b525cbc9d8f605e0&units=metric
//kubus tu masz linka jak to wyglada jak cos 