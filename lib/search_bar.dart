
import 'package:flutter/material.dart';

class WeatherSearchBar extends StatelessWidget {
  WeatherSearchBar({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: SearchBar(
        controller: controller,
        hintText: "Szukaj",
        leading: Icon(Icons.search),

        shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
      )
    );
  }
}