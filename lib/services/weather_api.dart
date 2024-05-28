import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/models/weather_model.dart';


class WeatherApi {
  String apiKey = "0943f00e7daf62d1b525cbc9d8f605e0";
  String currentUrl = 'https://api.openweathermap.org/data/2.5/weather';
  String hourlyUrl = 'https://api.openweathermap.org/data/2.5/forecast/hourly';


  Future<CurrentWeather> getCurrentWeather(String city) async {
    final response = await http.get(Uri.parse('$currentUrl?q=$city&appid=$apiKey&units=metric'));
    print(response.statusCode);
    if (response.statusCode == 200) { //200 oznacza sukces
      final json = jsonDecode(response.body);
      return CurrentWeather.fromJson(json);
    } else {
      throw Exception('Failed to load current weather data');
    }
  }

  Future<List<HourlyWeather>> getHourlyWeather(String city) async {
    //List<double> coordinates = await getCoordinates(city);
    //print(coordinates);
    final response = await http.get(Uri.parse('$hourlyUrl?q=$city&appid=$apiKey&units=metric'));
    print(response.statusCode);
    if (response.statusCode == 200) { //200 oznacza sukces
      final json = jsonDecode(response.body);
      print(json);
      List<HourlyWeather> hourlyWeatherList = [];

      for(int i = 0; i < 1; i++) {
        HourlyWeather hw = HourlyWeather.fromJson(json,i);
        if(hw.state != null && hw.hour != null) hourlyWeatherList.add(hw);
        print(hw);
      }

      return hourlyWeatherList;
    } else {
      throw Exception('Failed to load hourly weather data');
    }
  }
}