# What The Weather - weather app

A flutter project for weather update. The app will get the user current location and using Open Weather Map api it will show the current weather of that location also the sunrise and sunset time along with houely update.
<table>

  <tr>
    <td>Home Screen</td>
    <td><img src="https://raw.githubusercontent.com/ZRShamim/what_the_weather/main/assets/screenshots/weather_app.png" width=350  ></td>
  </tr>  

 </table>

## Code Flow:
For managing state I am using GetX ^4.6.5. All the screens are in pages folder and UI components are inside widget folder.

```
└── lib/
    ├── controller/
    ├── model/
    ├── services/
    │   └── Api services file to fetch data
    └── view/
        ├── rootpage.dart
        ├── global_widgets/
        │   └── UI components
        └── screens/
            └── different screens
```
## API
```
Open Weather: https://openweathermap.org/api
```

## Dependencies
```
  intl: ^0.17.0
  http: ^0.13.4
  get: ^4.6.5
  geolocator: ^8.2.1
  flutter_native_splash: ^2.1.6
```


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
