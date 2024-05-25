import 'package:flutter/material.dart';
import 'package:weather_app/search_bar.dart';
import 'package:weather_app/texts.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            
            //Search bar
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed:() {},
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: WeatherSearchBar(),
                ),
              ],
            ),
            
            //City name
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: CityTitle(
                text: "W R O C Ł A W",
              ),
            ),
      
            //Animation
            Lottie.asset("assets/sun_animation.json",
              
              height: 150,
              
            ),
      
            //Temperature
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("24\u2103\nSłonecznie ",
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
                  Text("GODZINOWA"),
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
