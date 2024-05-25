String animation(String description) {
  switch(description.toLowerCase()) {
    case "słonecznie": return "assets/sun_animation.json";
    case "burza" : return "assets/storm_animation.json";
    case "zachmurzenie" : return "assets/cloudy_animation.json";
    default: return "assets/sun_animation.json";
  }
}