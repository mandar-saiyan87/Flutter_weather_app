// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_import, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/utils/location.dart';

import '../utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      debugPrint('Location information not available');
    } else {
      debugPrint('latitude: ${locationData.latitude.toString()}');
      debugPrint('longitude: ${locationData.longitude.toString()}');
    }
  }

  void getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationHelper: locationData);
    await weatherData.getCurrentTemp();
    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print('no values from api');
    }
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return MainScreen(weatherData: weatherData);
      },
    ));
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    // getLocationData();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pink.shade200, Colors.purple.shade600],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
        ),
        child: SpinKitFadingCircle(
          color: Colors.blue.shade300,
          size: 50,
          duration: Duration(milliseconds: 1500),
        ),
      ),
    );
  }
}
