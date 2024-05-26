import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/models/weather_model.dart';

class WeatherApi {
  String apiKey = "0943f00e7daf62d1b525cbc9d8f605e0";
  String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> getWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) { //200 oznacza sukces
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}