import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/digest_weather_data.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherTile extends StatefulWidget {
  HourlyWeather? weather;

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
            '${widget.weather?.hour}:00',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Row(
            children: [
              Text(
                '${widget.weather?.temperature}\u2103',
                style: Theme.of(context).textTheme.bodyMedium, 
              ),
              Lottie.asset(
                animation(widget.weather?.weatherCode,widget.weather?.day),
                height: 40.0
                
                ),
            ],
          ),
        ],
      ),
    );
  }
}
