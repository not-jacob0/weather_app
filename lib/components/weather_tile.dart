import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/digest_weather_data.dart';
import 'package:weather_app/models/weather/daily_weather.dart';
import 'package:weather_app/models/weather/hourly_weather.dart';

class WeatherTile extends StatefulWidget {
  final dynamic weather; 

  const WeatherTile({Key? key, required this.weather}) : super(key: key);

  @override
  State<WeatherTile> createState() => _WeatherTileState();
}

class _WeatherTileState extends State<WeatherTile> {
  @override
  Widget build(BuildContext context) {
    if (widget.weather is HourlyWeather) {
      HourlyWeather hourlyWeather = widget.weather;
      return InkWell(
        onTap: () {},
        splashColor: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(4.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${hourlyWeather.hour}:00',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Lottie.asset(
                animation(hourlyWeather.weatherCode, hourlyWeather.day),
                height: 60.0,
              ),
              Text(
                '${hourlyWeather.temperature}\u2103',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      );
    } else if (widget.weather is DailyWeather) {
      DailyWeather dailyWeather = widget.weather;
      return InkWell(
        onTap: () {},
        splashColor: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(4.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                dailyWeather.dayOfWeek,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Lottie.asset(
                animation(dailyWeather.weatherCode, dailyWeather.day),
                height: 60.0,
              ),
              Text(
                '${dailyWeather.maxTemperature}\u2103 / ${dailyWeather.minTemperature}\u2103',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
