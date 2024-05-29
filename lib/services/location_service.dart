import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


Future<Map<String, double>> getCoordinatesFromCity(String cityName) async {
  try {
    List<Location> locations = await locationFromAddress(cityName);

    if (locations.isNotEmpty) {
      final location = locations.first;
      return {
        'latitude': location.latitude,
        'longitude': location.longitude
      };
    } else {
      throw Exception('No locations found for the city: $cityName');
    }
  } catch (e) {
    throw Exception('Failed to get coordinates: $e');
  }
}
  

Future<String> getCity() async {

  //sprawdza czy lokalizacja jest wlaczona
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location is disabled');
  }

  //sprawdza czy aplikacja ma uprawnienia
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  Position position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  if (placemarks.isEmpty) {
    return Future.error('No city found');
  }
  return placemarks.first.locality ?? 'Unknown city';
}


