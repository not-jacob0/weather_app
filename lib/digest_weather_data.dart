String animation(String? description) {
  if(description == null) return "";
  switch(description.toLowerCase()) {
    case "clear sky": return "assets/sun_animation.json";
    case "burza" : return "assets/storm_animation.json";
    case "zachmurzenie" : return "assets/cloudy_animation.json";
    default: return "assets/sun_animation.json";
  }
}

String weatherDescription(String? description) {
  if(description == null) return "";

  switch(description.toLowerCase()) {
    case "clear sky": return "Słonecznie";
    default: return "-";
  }
}