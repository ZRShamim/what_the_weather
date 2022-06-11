import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xfff5cb42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Image.asset(
              'assets/weather_image/sunny.png',
              width: 300,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text("Fetching Data..."),
            ),
          ],
        ),
      ),
    );
  }
}
