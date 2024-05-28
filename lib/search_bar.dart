import 'package:flutter/material.dart';

class WeatherSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onSubmitted;
  const WeatherSearchBar(
      {super.key, required this.controller, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: SearchBar(
          controller: controller,
          hintText: "Szukaj",
          leading: Icon(Icons.search),
          trailing: <Widget>[
            GestureDetector(
              onTap: onSubmitted,
              child: const Icon(Icons.add),
            )
          ],
          shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
        ));
  }
}
