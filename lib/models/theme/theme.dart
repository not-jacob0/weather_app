import 'package:flutter/material.dart';

ColorScheme lightColorScheme = ColorScheme.light(
    primary: Colors.amber.shade400, //jakis tam główny kolor
    secondary: Colors.grey.shade700,
    tertiary: Colors.black,
);

ColorScheme darkColorScheme = ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.amber.shade400, //jakis tam główny kolor
    secondary: Colors.grey.shade300,
    tertiary: Colors.white,//text
);

ThemeData lightMode = ThemeData(
  fontFamily: 'Lato',
  colorScheme: lightColorScheme,
  textTheme: TextTheme(
    headlineLarge: TextStyle( color: lightColorScheme.tertiary,),//nazwa miasta
    bodyMedium: TextStyle(color: lightColorScheme.secondary),//temperatura
    titleMedium: TextStyle(color: lightColorScheme.tertiary), //labels - teraz godzinowa na 16 dni
    bodyLarge: TextStyle(color: lightColorScheme.secondary) // godzina i temperatura

  )
);

ThemeData darkMode = ThemeData(
  fontFamily: 'Lato',
  colorScheme: darkColorScheme,
  textTheme: TextTheme(
    headlineLarge: TextStyle( color: darkColorScheme.tertiary,),//nazwa miasta
    bodyMedium: TextStyle(color: darkColorScheme.secondary),//temperatura
    titleMedium: TextStyle(color: darkColorScheme.tertiary), //labels - teraz godzinowa na 16 dni
    bodyLarge: TextStyle(color: darkColorScheme.secondary) // godzina i temperatura

  )


);