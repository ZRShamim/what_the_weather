import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_insta_to_flutter/services/weather_api.dart';
import 'package:get/get.dart';

import '../model/weather_bulk_info.dart';

class WeatherInfoController extends GetxController {
  RxBool loading = true.obs;
  String? humidity;
  String? temp;
  String? country;
  String? areaName;
  String? weatherType;
  String? weatherDescription;
  String? secondaryWeatherType;
  String? secondaryWeatherDescription;
  String? tempFeelsLike;
  String? tempMin;
  String? tempMax;
  String? windSpeed;
  String? sunrise;
  String? sunset;
  String? visibility;
  List<Current> hourly = [];

  String? tempSunRise = '';

  @override
  void onInit() async {
    var currentPosition = await _determinePosition();
    var lat = currentPosition.latitude;
    var lon = currentPosition.longitude;
    var key = 'ecc8334274eff052cd22f14eb09eca09';
    var url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$key';
    weatherList(url);
    url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$key';
    weatherHourlyList(url);
    super.onInit();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<void> weatherList(String url) async {
    // loading(true);
    try {
      var weatherInfo = await ApiService.fetchWeatherInfolist(url);
      if (weatherInfo != null) {
        humidity = (weatherInfo.main.humidity).toString();
        temp = ((weatherInfo.main.temp - 273.15).round()).toString();
        country = weatherInfo.sys.country;
        areaName = weatherInfo.name;
        weatherType = weatherInfo.weather[0].main;
        weatherDescription = weatherInfo.weather[0].description;
        tempFeelsLike = ((weatherInfo.main.feelsLike - 273.15).round())
            .toString()
          ..toString();
        tempMin = ((weatherInfo.main.tempMin - 273.15).round()).toString();
        tempMax = ((weatherInfo.main.tempMax - 273.15).round()).toString();
        windSpeed = (weatherInfo.wind.speed).toString();
        visibility = (weatherInfo.visibility / 1000).toString();

        sunset = (DateFormat('hh:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(
                    weatherInfo.sys.sunset * 1000)))
            .toString();

        sunrise = (DateFormat('hh:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(
                    weatherInfo.sys.sunrise * 1000)))
            .toString();
      }
    } finally {
      // loading(false);
    }
  }

  Future<void> weatherHourlyList(String url) async {
    // loading(true);
    try {
      var weatherInfo = await ApiService.fetchWeatherBulkInfolist(url);
      // print(weatherInfo);
      if (weatherInfo != null) {
        hourly = weatherInfo.hourly;
      }
    } finally {
      loading(false);
    }
  }
}
