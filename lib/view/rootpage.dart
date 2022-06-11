import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_insta_to_flutter/view/screens/home_screen.dart';
import 'package:weather_insta_to_flutter/view/screens/loading_screen.dart';

import '../controller/weather_info_controller.dart';

class RootPage extends StatelessWidget {
  RootPage({Key? key}) : super(key: key);

  WeatherInfoController weatherInfoController =
      Get.put(WeatherInfoController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Obx(
        () {
          return weatherInfoController.loading.value
              ? const LoadingScreen()
              : HomeScreen();
        },
      ),
    );
  }
}
