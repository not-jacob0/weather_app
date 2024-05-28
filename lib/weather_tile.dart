import 'package:flutter/material.dart';
import 'package:weather_app/texts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/digest_weather_data.dart';
import 'package:weather_app/weather_classes.dart';

class WeatherTile extends StatefulWidget {
  HourlyWeather weather;

  WeatherTile({Key? key,required this.weather}) : super(key: key);

  @override
  State<WeatherTile> createState() => _WeatherTileState();
}

class _WeatherTileState extends State<WeatherTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(4.0), // Usunięcie domyślnego wewnętrznego wypełnienia ListTile
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Wyrównanie elementów do krawędzi
        children: [
          Text(
            '${widget.weather.hour}:00',
            style: const TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                '${widget.weather.temperature}\u2103',
                style: const TextStyle(fontSize: 18.0),
              ),
              Lottie.asset(
                animation(widget.weather.description),
                height: 40.0
                
                ),
            ],
          ),
        ],
      ),
    );
  }
}
