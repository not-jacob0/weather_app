import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Lato',
  colorScheme: ColorScheme.light(
    //background: Colors.transparent,
    primary: Colors.amber.shade400, //jakis tam główny kolor
    secondary: Colors.grey.shade600,
    tertiary: Colors.black87,
  ),

);

ThemeData darkMode = ThemeData(
  fontFamily: 'Lato',
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade900,
    primary: Colors.amber.shade400, //jakis tam główny kolor
    secondary: Colors.grey.shade800,
    tertiary: Colors.white70,//text
    
  ),

);