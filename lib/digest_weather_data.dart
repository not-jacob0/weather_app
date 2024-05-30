String animation(int? weatherCode, bool? day) {
  if (weatherCode == null) return "assets/loading_animation.json";
  switch (weatherCode) {
    case 3:
      return "assets/cloudy_animation.json";

    case 95:
    case 96:
    case 99:
      return "assets/storm_animation.json";

    case 1:
    case 0:
      return (day == null)
          ? "assets/sun_animation.json"
          : (day ? "assets/sun_animation.json" : "assets/moon_animation.json");

    case 71:
    case 73:
    case 75:
    case 77:
      return "assets/snow_animation.json";

    case 51:
    case 53:
    case 55:
    case 56:
    case 57:
    case 61:
    case 63:
    case 65:
    case 66:
    case 67:
    case 80:
    case 81:
    case 82:
    case 5:
      return (day == null)
          ? "assets/rain_animation.json"
          : (day
              ? "assets/rain_animation.json"
              : "assets/moon_rain_animation.json");

    case 2:
      return (day == null)
          ? "assets/partly_cloudy_animation.json"
          : (day
              ? "assets/partly_cloudy_animation.json"
              : "assets/moon_cloudy_animation.json");

    case 45:
    case 48:
      return "assets/fog_animation.json";

    default:
      return "assets/sun_animation.json";
  }
}

String weatherDescription(int? weatherCode, bool? day) {
  if (weatherCode == null) return "";

  switch (weatherCode) {
    case 0:
    case 1:
      return  day == null
              ? "Bezchmurnie"
              : day 
                ? "Słonecznie"
                : "Bezchmurnie";
    case 2:
      return "Częściowo pochmurnie";
    case 3:
      return "Pochmurnie";
    case 45:
      return "Mgła";
    case 48:
      return "Szadź";
    case 51:
      return "Lekka mżawka";
    case 53:
      return "Umiarkowana mżawka";
    case 55:
      return "Gęsta mżawka";
    case 56:
      return "Lekka marznąca mżawka";
    case 57:
      return "Gęsta marznąca mżawka";
    case 61:
      return "Lekki deszcz";
    case 63:
      return "Umiarkowany deszcz";
    case 65:
      return "Intensywny deszcz";
    case 66:
      return "Lekki marznący deszcz";
    case 67:
      return "Intensywny marznący deszcz";
    case 71:
      return "Lekki śnieg";
    case 73:
      return "Umiarkowany śnieg";
    case 75:
      return "Intensywny śnieg";
    case 77:
      return "Ziarnisty śnieg";
    case 80:
      return "Lekki deszczowy przelotny";
    case 81:
      return "Umiarkowany deszczowy przelotny";
    case 82:
      return "Gwałtowny deszczowy przelotny";
    case 85:
      return "Lekki śnieżny przelotny";
    case 86:
      return "Intensywny śnieżny przelotny";
    case 95:
      return "Słaba burza";
    case 96:
      return "Lekki grad";
    case 99:
      return "Intensywny grad";
    default:
      return "-";
  }
}
