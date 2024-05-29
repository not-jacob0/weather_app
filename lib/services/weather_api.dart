import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';


class WeatherApi {
  String url = 'https://api.open-meteo.com/v1/forecast';
  String urlRest = '&current=temperature_2m,apparent_temperature,precipitation,weather_code,cloud_cover,wind_speed_10m&hourly=temperature_2m,apparent_temperature,precipitation_probability,weather_code,surface_pressure,cloud_cover,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum&timezone=auto';

  Future<CurrentWeather> getCurrentWeather(String city) async {
    Map<String,double> cords = await getCoordinatesFromCity(city);

    final response = await http.get(Uri.parse('$url?latitude=${cords['latitude']}&longitude=${cords['longitude']}$urlRest'));

    if (response.statusCode == 200) { //200 oznacza sukces
      final json = jsonDecode(response.body);
      return CurrentWeather.fromJson(json);
    } else {
      throw Exception('Failed to load current weather data');
    }
  }

  Future<List<HourlyWeather>> getHourlyWeather(String city) async {
    Map<String,double> cords = await getCoordinatesFromCity(city);

    final response = await http.get(Uri.parse('$url?latitude=${cords['latitude']}&longitude=${cords['longitude']}$urlRest'));

    if (response.statusCode == 200) { //200 oznacza sukces
      final json = jsonDecode(response.body);
      List<HourlyWeather> hourlyWeatherList = [];
      int currentHour = DateTime.parse(json['current']['time']).hour;

      for(int i = currentHour+1; i < currentHour+25; i++) {
        HourlyWeather hw = HourlyWeather.fromJson(json,i);
        hourlyWeatherList.add(hw);
      }

      return hourlyWeatherList;
    } else {
      throw Exception('Failed to load hourly weather data');
    }
  }
}