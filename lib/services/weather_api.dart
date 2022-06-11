import 'package:http/http.dart' as http;

import '../model/weather_bulk_info.dart';
import '../model/weather_info.dart';

class ApiService {
  static var client = http.Client();

  static Future<WeatherInfo?> fetchWeatherInfolist(String url) async {
    var response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return weatherInfoFromJson(jsonString);
    } else {
      // print('No Data Found');
    }
  }

  static Future<WeatherBulkInfo?> fetchWeatherBulkInfolist(String url) async {
    var response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return weatherBulkInfoFromJson(jsonString);
    } else {
      // print('No Data Found');
    }
  }
}
