import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/digest_weather_data.dart';
import 'package:weather_app/models/theme/theme_provider.dart';
import 'package:weather_app/search_bar.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/weather_tile.dart';
import 'package:weather_app/models/theme/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData ,
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
      
      city = await getCity();
      getWeather(city);
    } catch (exn) {
      print(exn);
    }
  }

  void toggleTheme() {

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
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
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
              style: TextStyle(
                fontSize: 32.0,
                color: Theme.of(context).colorScheme.tertiary
              ),
            ),
          ),

          //Animation
          Lottie.asset(
            animation(currentWeather?.weatherCode,currentWeather?.day),
            height: 150,
          ),

          //Temperature
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
                "${currentWeather?.temperature.round()}\u2103\n${weatherDescription(currentWeather?.weatherCode,currentWeather?.day)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0, 
                  color: Theme.of(context).colorScheme.secondary,
                  )
                ),
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
                  itemCount: hourlyWeatherList?[0] == null ? 0 : hourlyWeatherList?.length,
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
