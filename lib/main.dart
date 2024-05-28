import 'package:flutter/material.dart';
import 'package:weather_app/digest_weather_data.dart';
import 'package:weather_app/search_bar.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/texts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/weather_classes.dart';
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
  Weather? weather;
  String city = "";

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async {
    try {
      Location location = Location();
      city = await location.getCity();
      setState(() {});
      Weather fetchedweather = await weatherApi.getWeather(city);
      setState(() {
        weather = fetchedweather;
      });
    } catch (exn) {
      print(exn);
    }
  }

  //testowe wartości
  List<HourlyWeather> hourlyWeather = [
    HourlyWeather(hour: 10, temperature: 24, description: "Słonecznie"),
    HourlyWeather(hour: 11, temperature: 19, description: "Burza"),
    HourlyWeather(hour: 12, temperature: 18, description: "Zachmurzenie"),
    HourlyWeather(hour: 13, temperature: 20, description: "Pochmurno"),
    HourlyWeather(hour: 14, temperature: 22, description: "Słonecznie"),
    HourlyWeather(hour: 15, temperature: 23, description: "Lekkie opady deszczu"),
    HourlyWeather(hour: 16, temperature: 22, description: "Pochmurno"),
    HourlyWeather(hour: 17, temperature: 21, description: "Burza"),
    HourlyWeather(hour: 18, temperature: 20, description: "Słabe opady deszczu"),
    HourlyWeather(hour: 19, temperature: 19, description: "Zachmurzenie"),
    HourlyWeather(hour: 20, temperature: 18, description: "Słabe opady śniegu"),
    HourlyWeather(hour: 21, temperature: 17, description: "Pochmurno"),
    HourlyWeather(hour: 22, temperature: 16, description: "Burza"),
    HourlyWeather(hour: 23, temperature: 15, description: "Deszcz ze śniegiem"),
    HourlyWeather(hour: 00, temperature: 14, description: "Zachmurzenie"),
  ];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            
            //Search bar
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed:() {},
                  ),
              
                  WeatherSearchBar(),
                  
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
            Lottie.asset("assets/sun_animation.json",
              
              height: 150,
              
            ),
      
            //Temperature
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("${weather?.temperature.round()}\u2103\n${weatherDescription(weather?.state)}",
              textAlign: TextAlign.center,
                style: MyTextStyle(
                  fontSize: 14.0,
                  color: Colors.grey
                )
              ),
            ),
      
      
      
            TabBar(tabs: [
      
              Tab(
                text: "TERAZ",
              ),
              Tab(
                text: "GODZINOWA"
              ),
              Tab(
                text: "NA 16 DNI"
              )
            ]),
      
            Expanded(
              child: TabBarView(
                
                children: [
                  Text("TERAZ"),


                    ListView.builder(
                      itemCount: hourlyWeather.length,
                      itemBuilder: (BuildContext context, int index) => 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: WeatherTile(weather: hourlyWeather[index],
                        ),
                      )
                  ),


                  Text("NA 16 DNI")
                ]
                ),
            )
      
          ]
        ),
      ),
    );
  }
}
