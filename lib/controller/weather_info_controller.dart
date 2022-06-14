import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_insta_to_flutter/services/weather_api.dart';
import 'package:get/get.dart';

import '../model/weather_bulk_info.dart';

class WeatherInfoController extends GetxController {
  RxBool loading = false.obs;
  RxBool isLocationActive = false.obs;
  RxBool isLocationpermissionDenied = false.obs;
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
  String? icon;
  List<Current> hourly = [];

  String? tempSunRise = '';
  // RxBool isLocActivate = false.obs;
  var key = 'ecc8334274eff052cd22f14eb09eca09';

  Future<Position> determinePosition() async {
    // isLocActivate(false);
    loading(true);
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
        isLocationpermissionDenied.value = true;
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isLocationpermissionDenied.value = true;
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    isLocationpermissionDenied.value = false;
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<void> weatherList(double lon, double lat) async {
    loading(true);
    String urlOneCall =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$key';
    String urlCurrent =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$key';

    // loading(true);
    try {
      var weatherOneCall =
          await ApiService.fetchWeatherBulkInfolist(urlOneCall);
      var weatherCurrent = await ApiService.fetchWeatherInfolist(urlCurrent);

      // print(weatherInfo);
      if (weatherOneCall != null && weatherCurrent != null) {
        hourly = weatherOneCall.hourly;
        humidity = (weatherCurrent.main.humidity).toString();
        temp = ((weatherCurrent.main.temp - 273.15).round()).toString();
        country = weatherCurrent.sys.country;
        areaName = weatherCurrent.name;
        weatherType = weatherCurrent.weather[0].main;
        icon = weatherCurrent.weather[0].icon;
        weatherDescription = weatherCurrent.weather[0].description;
        tempFeelsLike = ((weatherCurrent.main.feelsLike - 273.15).round())
            .toString()
          ..toString();
        tempMin = ((weatherCurrent.main.tempMin - 273.15).round()).toString();
        tempMax = ((weatherCurrent.main.tempMax - 273.15).round()).toString();
        windSpeed = (weatherCurrent.wind.speed).toString();
        visibility = (weatherCurrent.visibility / 1000).toString();

        sunset = (DateFormat('hh:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(
                    weatherCurrent.sys.sunset * 1000)))
            .toString();

        sunrise = (DateFormat('hh:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(
                    weatherCurrent.sys.sunrise * 1000)))
            .toString();
      }
    } finally {
      loading(false);
      isLocationActive(true);
    }
  }
}
