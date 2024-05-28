import 'package:flutter/material.dart';
import 'package:weather_app/digest_weather_data.dart';
import 'package:weather_app/search_bar.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/texts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/weather_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherApi weatherApi = WeatherApi();
  CurrentWeather? currentWeather;
  List<HourlyWeather?>? hourlyWeatherList;
  String city = "";
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getWeatherFromLocation();
  }

  void getWeather(String cityToCheck) async {
    try {
      setState(() {});
      CurrentWeather fetchedCurrWeather = await weatherApi.getCurrentWeather(cityToCheck);
      List<HourlyWeather> fetchedHourlyWeather = await weatherApi.getHourlyWeather(cityToCheck);
      setState(() {
        currentWeather = fetchedCurrWeather;
        hourlyWeatherList= fetchedHourlyWeather;
      });
      city = cityToCheck;
    } catch(e) {
      print("Błąd pobierania danych o pogodzie: $e");
    }
  }

  void getWeatherFromLocation() async {
    try {
      Location location = Location();
      city = await location.getCity();
      getWeather(city);
    } catch (exn) {
      print(exn);
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(children: [
          //Search bar
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),

                Expanded(
                  child: WeatherSearchBar(
                    controller: _controller,
                    onSubmitted: () {
                      getWeather(_controller.text);
                    },
                  ),
                ),
                const SizedBox(width: 10) // Spacer
              ],
            ),
          ),

          //City name
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: CityTitle(
              text: city.toUpperCase(),
            ),
          ),

          //Animation
          Lottie.asset(
            "assets/sun_animation.json",
            height: 150,
          ),

          //Temperature
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
                "${currentWeather?.temperature.round()}\u2103\n${weatherDescription(currentWeather?.state)}",
                textAlign: TextAlign.center,
                style: MyTextStyle(fontSize: 14.0, color: Colors.grey)),
          ),

          TabBar(tabs: [
            Tab(
              text: "TERAZ",
            ),
            Tab(text: "GODZINOWA"),
            Tab(text: "NA 16 DNI")
          ]),

          Expanded(
            child: TabBarView(children: [
              Text("TERAZ"),

              ListView.builder(
                  itemCount: hourlyWeatherList?.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: WeatherTile(
                          weather: hourlyWeatherList?[index],
                        ),
                      )),
              Text("NA 16 DNI")
            ]),
          )
        ]),
      ),
    );
  }
}
