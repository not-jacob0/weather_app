class Weather {
  int weatherCode; // stan pogody np. słońce, pada itp.
  double temperature;
  bool? day; // dzień - true | noc - false

  Weather({
    required this.weatherCode,
    required this.temperature,
    this.day,
  });
}