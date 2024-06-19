# Aplikacja pogodowa

Aplikacja pokazuje pogodę w wybranym mieście.
Przy pierwszym uruchomieniu, aplikacja sprawdza lokalizację i na jej podstawie pokazuje pogodę dla miasta, w którym się znajdujemy.
Pogoda na teraz: Obrazek pogody, temperatura, opis pogody, opady, prędkość wiatru, zachmurzenie.
Pogoda godzinowa: Dla danej godziny podana jest temperatura oraz obrazek pokazujący tę pogodę
Pogoda na 7 dni: Dla danego dnia podana jest najmniejsza i największa temperatura oraz obrazek pokazujący przeważającą tego dnia pogodę

Pasek wyszukiwania umożliwia wpisanie miasta. Po kliknięciu ikonki lupy dostaniemy pogodę z tego miasta, które wyszukaliśmy.
Możliwa jest też zmiana z białego trybu na ciemny i na odwrót.

## Opis klas

Weather - główna klasa pogodowa
  int weatherCode; // stan pogody np. słońce, pada itp.
  double temperature;
  bool? day; // dzień - true | noc - false

CurrentWeather - dziedziczy pola po Weather - trzyma dane dotyczące pogody na teraz
  int precipitation; // Szansa na opady
  double windSpeed;
  int cloudCover;

HourlyWeather - dziedziczy pola po Weather - trzyma dane dotyczące pogody na daną godzinę
  int hour;

DailyWeather - dziedziczy pola po Weather - trzyma dane dotyczące pogody na dany dzień
  String dayOfWeek;
  double minTemperature;
  double maxTemperature;

ThemeProvider - dotyczy trybu jasnego i ciemnego
  ThemeData _themeData - przechowuje aktualny tryb
  void toggleTheme() - zmienia tryb na przeciwny

WeatherApi - obsługuje update'owanie danych z pogodowego API, którego używamy
  String url - adres API
  String urlRest - trzyma resztę adresu API po kluczu
  Future<Map<String, dynamic>> fetchData(String city) async  - pobiera dane z API i sprawdza, czy wszystko poszło po drodze dobrze

  Future<CurrentWeather> getCurrentWeather(String city) async - trawi pobrane dane i tworzy klasę CurrentWeather z tymi danymi

  Future<List<HourlyWeather>> getHourlyWeather(String city) async - trawi pobrane dane i tworzy klasy HourlyWeather na każdą godzinę

  Future<List<DailyWeather>> getDailyWeather(String city) async - trawi pobrane dane i tworzy klasy DailyWeather na każdy dzień

## Bibliografia

https://www.youtube.com/watch?v=-jdtfJe_sII&ab_channel=MitchKoko
https://www.youtube.com/watch?v=yLtpMqvMgdY&ab_channel=MitchKoko

## Autorzy
Mateusz Matyskiel
Jakub Harewicz
