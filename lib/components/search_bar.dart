import 'package:flutter/material.dart';

class WeatherSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onSubmitted;
  const WeatherSearchBar(
      {super.key, required this.controller, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary, // Kolor obramowania
          width: 1.0, // Grubość obramowania
        ),
      ),
      child: SearchBar(
        surfaceTintColor: MaterialStateColor.resolveWith((states) {
          return Colors.transparent;
        }),
        hintStyle:
            MaterialStateProperty.all(Theme.of(context).textTheme.bodyMedium),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        controller: controller,
        hintText: "Szukaj",
        trailing: <Widget>[
          GestureDetector(
            onTap: onSubmitted,
            child: const Icon(Icons.search),
          )
        ],
        shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
      ),
    );
  }
}
