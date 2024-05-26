//tutaj beda zawarte najwazniejsze informacje o pogodzie

class Weather {
  String city;
  String state ;//stan pogody np. slonce, pada itp
  double temperature;
  double feelsLikeTemperature;
  double windSpeed;
  //mozna dodac co sie chce w sumie

  Weather ({
    required this.city,
    required this.state,
    required this.temperature,
    required this.feelsLikeTemperature,
    required this.windSpeed,
  });

  //konwertujemy plik json na dane
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      state: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      feelsLikeTemperature: json['main']['feels_like'],
      windSpeed: json['wind']['speed']
    );
  }

}

//https://api.openweathermap.org/data/2.5/weather?q=Wroc%C5%82aw&appid=0943f00e7daf62d1b525cbc9d8f605e0&units=metric
//kubus tu masz linka jak to wyglada jak cos 