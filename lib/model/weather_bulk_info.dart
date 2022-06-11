// To parse this JSON data, do
//
//     final weatherBulkInfo = weatherBulkInfoFromJson(jsonString);
import 'dart:convert';

WeatherBulkInfo weatherBulkInfoFromJson(String str) =>
    WeatherBulkInfo.fromJson(json.decode(str));

class WeatherBulkInfo {
  WeatherBulkInfo({
    required this.current,
    required this.hourly,
    required this.daily,
  });
  final Current? current;
  final List<Current> hourly;
  final List<Daily>? daily;

  factory WeatherBulkInfo.fromJson(Map<String, dynamic> json) =>
      WeatherBulkInfo(
        current: Current.fromJson(json["current"]),
        hourly:
            List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );
}

class Current {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  final int? dt;
  final int? sunrise;
  final int? sunset;
  final double? temp;
  final double? feelsLike;
  final int? humidity;
  final double? uvi;
  final int? clouds;
  final int? visibility;
  final double? windSpeed;
  final int? windDeg;
  final List<Weather>? weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        humidity: json["humidity"],
        uvi: json["uvi"].toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );
}

class Daily {
  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });

  final int? dt;
  final int? sunrise;
  final int? sunset;
  final Temp? temp;
  final int? humidity;
  final double? windSpeed;
  final List<Weather>? weather;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: Temp.fromJson(json["temp"]),
        humidity: json["humidity"],
        windSpeed: json["wind_speed"].toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );
}

class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final double? day;
  final double? min;
  final double? max;
  final double? night;
  final double? eve;
  final double? morn;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"].toDouble(),
        min: json["min"].toDouble(),
        max: json["max"].toDouble(),
        night: json["night"].toDouble(),
        eve: json["eve"].toDouble(),
        morn: json["morn"].toDouble(),
      );
}
