//tutaj beda zawarte najwazniejsze informacje o pogodzie

class CurrentWeather {
  String? city;
  String state ;//stan pogody np. slonce, pada itp
  double temperature;
  //mozna dodac co sie chce w sumie

  CurrentWeather ({
    this.city,
    required this.state,
    required this.temperature,

  });

  //konwertujemy plik json na dane
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      city: json['name'],
      state: json['weather'][0]['description'],
      temperature: json['main']['temp'],
    );
  }

}


class HourlyWeather extends CurrentWeather {
  int hour;

  HourlyWeather({
    required this.hour,
    required String state,
    required double temperature,

  }) : super(state: state, temperature: temperature);

    //konwertujemy plik json na dane
  factory HourlyWeather.fromJson(Map<String, dynamic> json,int index) {
    return HourlyWeather(
      state: json['list'][index]['weather']['description'],
      temperature: json['list'][index]['main']['temp'],
      hour: DateTime.parse(json['list'][index]['dt_txt']).hour
    );
  }

}

class DailyWeather extends CurrentWeather {
  String date;

  DailyWeather({
    required this.date,
    required String state,
    required double temperature
  }) : super(state: state, temperature: temperature);
}

//https://api.openweathermap.org/data/2.5/weather?q=Wroc%C5%82aw&appid=0943f00e7daf62d1b525cbc9d8f605e0&units=metric
//kubus tu masz linka jak to wyglada jak cos 