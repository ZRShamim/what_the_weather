import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_insta_to_flutter/controller/weather_info_controller.dart';
import 'package:weather_insta_to_flutter/model/weather_bulk_info.dart';
// import 'package:weather_insta_to_flutter/services/weather_api.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  WeatherInfoController weatherInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat.MMMd().format(DateTime.now()),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${weatherInfoController.areaName}, ${weatherInfoController.country}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: weatherInfoController.temp,
                            style: const TextStyle(
                                fontSize: 36,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' \u2070C',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Chip(
                      label: Text(
                        weatherInfoController.weatherType!,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      backgroundColor: Colors.blue[300],
                    )
                  ],
                ),
                Image.network(
                  'https://openweathermap.org/img/w/${weatherInfoController.icon}.png',
                )
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherCard(
                  info: '${weatherInfoController.humidity} %',
                  string: 'Humidity',
                  imgSrc: 'humidity',
                ),
                const SizedBox(
                  width: 10,
                ),
                WeatherCard(
                  info: '${weatherInfoController.windSpeed} m/s',
                  string: 'Wind Speed',
                  imgSrc: 'windy',
                ),
                const SizedBox(
                  width: 10,
                ),
                WeatherCard(
                  info: '${weatherInfoController.visibility} Km',
                  string: 'Visibility',
                  imgSrc: 'visibility',
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 100,
              color: Colors.grey[100],
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/weather_image/sunrise.png',
                          width: 70,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          weatherInfoController.sunrise!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        Text(
                          weatherInfoController.sunset!,
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/weather_image/sunset.png',
                          width: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 150,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    24,
                    (i) => HourlyWeatherWidget(
                        weather: weatherInfoController.hourly[i]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HourlyWeatherWidget extends StatelessWidget {
  const HourlyWeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Current weather;

  @override
  Widget build(BuildContext context) {
    var temp = (weather.temp! - 273.15).round();
    var time = (DateFormat('hh:mm a')
            .format(DateTime.fromMillisecondsSinceEpoch(weather.dt! * 1000)))
        .toString();

    var icon = weather.weather![0].icon;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          time.toString(),
          style: const TextStyle(fontSize: 12),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 60,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50,
            ),
            border: Border.all(
              color: const Color(0xffe0e0e0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$temp \u2070C',
              ),
              Image.network(
                'https://openweathermap.org/img/w/$icon.png',
              )
            ],
          ),
        ),
      ],
    );
  }
}

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    Key? key,
    required this.info,
    required this.string,
    required this.imgSrc,
  }) : super(key: key);

  final String info;
  final String string;
  final String imgSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width / 3 - 30,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/weather_image/$imgSrc.png',
            width: 60,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            info,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            string,
            style: const TextStyle(
              fontSize: 14,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
