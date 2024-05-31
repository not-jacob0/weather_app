import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/digest_weather_data.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherTile extends StatefulWidget {
  final dynamic weather; // Może to być HourlyWeather, DailyWeather lub CurrentWeather

  WeatherTile({Key? key, required this.weather}) : super(key: key);

  @override
  State<WeatherTile> createState() => _WeatherTileState();
}

class _WeatherTileState extends State<WeatherTile> {
  @override
  Widget build(BuildContext context) {
    if (widget.weather is HourlyWeather) {
      HourlyWeather hourlyWeather = widget.weather;
      return ListTile(
        contentPadding: EdgeInsets.all(4.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${hourlyWeather.hour}:00',
              style: const TextStyle(fontSize: 18.0),
            ),
            Row(
              children: [
                Text(
                  '${hourlyWeather.temperature}\u2103',
                  style: const TextStyle(fontSize: 18.0),
                ),
                Lottie.asset(
                  animation(weatherDescription(hourlyWeather.weatherCode)),
                  height: 40.0,
                ),
              ],
            ),
          ],
        ),
      );
    } else if (widget.weather is DailyWeather) {
      DailyWeather dailyWeather = widget.weather;
      return ListTile(
        contentPadding: EdgeInsets.all(4.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dailyWeather.day,
              style: const TextStyle(fontSize: 18.0),
            ),
            Row(
              children: [
                Text(
                  '${dailyWeather.maxTemperature}\u2103 / ${dailyWeather.minTemperature}\u2103',
                  style: const TextStyle(fontSize: 18.0),
                ),
                Lottie.asset(
                  animation(weatherDescription(dailyWeather.weatherCode)),
                  height: 40.0,
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
