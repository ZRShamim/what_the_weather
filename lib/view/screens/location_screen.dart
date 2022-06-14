import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_insta_to_flutter/view/screens/home_screen.dart';

import '../../controller/weather_info_controller.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({Key? key}) : super(key: key);

  WeatherInfoController weatherInfoController =
      Get.put(WeatherInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // const Color(0xfff5cb42),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              // width: 250,
              child: const Text(
                'We need your location.',
                style: TextStyle(
                  fontSize: 40,
                  letterSpacing: 4.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Obx(
              () => !weatherInfoController.isLocationpermissionDenied.value
                  ? !weatherInfoController.isLocationActive.value
                      ? Center(
                          child: GestureDetector(
                            onTap: () async {
                              Position location = await weatherInfoController
                                  .determinePosition();
                              double lon = location.longitude;
                              double lat = location.latitude;
                              weatherInfoController.weatherList(lon, lat);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              width: 350,
                              height: 70,
                              decoration: BoxDecoration(
                                color: const Color(0xfff5cb42),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: !weatherInfoController.loading.value
                                    ? const Text(
                                        'Get My Location',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                        ),
                                      )
                                    : const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Column(
                            children: [
                              const Text('We got your location'),
                              GestureDetector(
                                onTap: () {
                                  Get.off(() => HomeScreen());
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  width: 350,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff5cb42),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Go to Homepage',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                  : Text('We Need location permission to show the result'),
            ),
          ],
        ),
      ),
    );
  }
}
