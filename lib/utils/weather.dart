// ignore_for_file: constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps, avoid_print, prefer_const_constructors, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import "package:location/location.dart";
import 'package:weather_app/utils/location.dart';

const api_key = '888ac009afbd2fe9254588951274637a';

class WeatherDisplayData {
  Icon? weatherIcon;
  AssetImage? weatherImage;
  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationHelper});
  late LocationHelper locationHelper;

  double? currentTemperature;
  int? currentCondition;

  Future<void> getCurrentTemp() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationHelper.latitude}&lon=${locationHelper.longitude}&appid=${api_key}&units=metric');
    Response response = await get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);
      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
      } catch (e) {
        print(e);
      }
    } else {
      print('no value from api');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition! < 600) {
      return WeatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size: 45,
            color: Colors.white,
          ),
          weatherImage: AssetImage('assets/images/rainy.jpg'));
    } else {
      var now = new DateTime.now();
      if (now.hour >= 19) {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 45,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/images/night.jpg'));
      } else {
        return WeatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 45,
              color: Colors.white,
            ),
            weatherImage: AssetImage('assets/images/sunny.jpg'));
      }
    }
  }
}
