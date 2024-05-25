import 'package:flutter/material.dart';

//Bazowy styl tekstu. Warto go używać do wszystkich tekstów pojawiających się w aplikacji, aby zachować jakąś jednolitość stylową
class MyTextStyle extends TextStyle {
  final double? fontSize;
  final Color? color;

  const MyTextStyle({
    this.fontSize,
    this.color,
    FontWeight? fontWeight, 
    FontStyle? fontStyle,
    String? fontFamily, 
    // Możesz dodać więcej opcjonalnych parametrów, jeśli chcesz
  }) : super(
          fontSize: fontSize ?? 16.0, // Domyślny rozmiar czcionki to 16.0
          color: color ?? Colors.black, // Domyślny kolor czcionki to czarny
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          fontFamily: fontFamily ?? "Times New Roman"
          // Tutaj możesz przekazać inne opcjonalne parametry do konstruktora TextStyle
        );
}

class CityTitle extends StatelessWidget {
  final TextStyle? style;
  final String text;

  const CityTitle({
    Key? key,
    this.style,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? const MyTextStyle(fontSize: 32.0),
    );
  }
}
