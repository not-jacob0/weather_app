import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/info_tile.dart';
import 'package:weather_app/digest_weather_data.dart';
import 'package:weather_app/models/theme/theme_provider.dart';
import 'package:weather_app/components/search_bar.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/models/weather/daily_weather.dart';
import 'package:weather_app/models/weather/hourly_weather.dart';
import 'package:weather_app/models/weather/current_weather.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/components/weather_tile.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const MyHomePage(),
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
  List<DailyWeather>? dailyWeatherList;
  String city = "";
  bool isCelsius = true;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getWeatherFromLocation();
  }

  void getWeather(String cityToCheck) async {
    try {
      setState(() {});
      CurrentWeather fetchedCurrWeather =
          await weatherApi.getCurrentWeather(cityToCheck);
      List<HourlyWeather> fetchedHourlyWeather =
          await weatherApi.getHourlyWeather(cityToCheck);
      List<DailyWeather> fetchedDailyWeather =
          await weatherApi.getDailyWeather(cityToCheck);
      setState(() {
        currentWeather = fetchedCurrWeather;
        hourlyWeatherList = fetchedHourlyWeather;
        dailyWeatherList = fetchedDailyWeather;
      });
      city = cityToCheck;
    } catch (e) {
      print("Błąd pobierania danych o pogodzie: $e");
    }
  }

  void getWeatherFromLocation() async {
    try {
      city = await getCity();
      getWeather(city);
    } catch (exn) {
      print(exn);
    }
  }

  String changeTemperature(double? temperature) {
    if (temperature == null) return "";
    if (isCelsius) {
      return "${temperature.round()}\u2103";
    } else {
      return "${(temperature * (9 / 5) + 32).round()}\u2109";
    }
  }

  String changeWindSpeed(double? speed) {
    if (speed == null) return "";
    if (isCelsius) {
      return "${speed.toStringAsFixed(1)} km/h";
    } else {
      return "${(speed * 0.6214).toStringAsFixed(1)} mph";
    }
  }
  
  void changeUnits() {
    setState(() {
      isCelsius = !isCelsius;
    });
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
                  color: Theme.of(context).colorScheme.tertiary,
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                ),
                IconButton(
                  icon: Icon(isCelsius ? Icons.thermostat : Icons.thermostat_outlined),
                  color: Theme.of(context).colorScheme.tertiary,
                  onPressed: () {
                    changeUnits();
                  },
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
            child: Text(
              city.toUpperCase(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),

          //Animation
          Lottie.asset(
            animation(currentWeather?.weatherCode, currentWeather?.day),
            height: 180,
          ),

          //Temperature
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              currentWeather == null
                  ? ""
                  : "${changeTemperature(currentWeather?.temperature)}\n${weatherDescription(currentWeather?.weatherCode, currentWeather?.day)}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          SizedBox(height: 20.0),

          //TERAZ - GODZINOWA - NA 16 DNI
          TabBar(
              unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
              labelStyle: Theme.of(context).textTheme.titleMedium,
              labelColor: Theme.of(context).colorScheme.primary,
              tabs: [
                Tab(
                  text: "TERAZ",
                ),
                Tab(text: "GODZINOWA"),
                Tab(text: "NA 7 DNI")
              ]),

          //Weather display
          Expanded(
            child: TabBarView(children: [
              Column(
                children: [
                  InfoTile(leading: "Opady:", trailing: currentWeather?.precipitation == null ? "" : "${currentWeather?.precipitation}%"),
                  InfoTile(leading: "Prędkość wiatru:", trailing: currentWeather?.windSpeed == null ? "" : changeWindSpeed(currentWeather?.windSpeed)), 
                  InfoTile(leading: "Zachmurzenie:", trailing: currentWeather?.cloudCover == null ? "" : "${currentWeather?.cloudCover}%")
                ],
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Prędkość wiatru: ${currentWeather?.windSpeed ?? 'N/A'} km/h",
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //     Text(
              //       "Szansa na opady: ${currentWeather?.precipitation ?? 'N/A'}%",
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //     Text(
              //       "Zachmurzenie: ${currentWeather?.cloudCover ?? 'N/A'}%",
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //   ],
              // ),
              ListView.builder(
                  itemCount: hourlyWeatherList?[0] == null
                      ? 0
                      : hourlyWeatherList?.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: WeatherTile(
                          weather: hourlyWeatherList?[index],
                          isCelsius: isCelsius,
                        ),
                      )
              ),
              ListView.builder(
                  itemCount: dailyWeatherList?[0] == null
                      ? 0
                      : dailyWeatherList?.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: WeatherTile(
                          weather: dailyWeatherList?[index],
                          isCelsius: isCelsius,
                        ),
                      )
                ),
            ])
          ),
        ])
      )
    );
  }
}
