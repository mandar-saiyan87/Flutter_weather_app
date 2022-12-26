// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:location/location.dart';

class LocationHelper {
  double? longitude;
  double? latitude;

  Future<void> getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionStatus;
    LocationData _locationData;
    // Is service enabled.
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
      // Is permission granted
      _permissionStatus = await location.hasPermission();
      if (_permissionStatus == PermissionStatus.denied) {
        _permissionStatus = await location.requestPermission();
      }
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    //Everything Ok
    _locationData = await location.getLocation();
    longitude = _locationData.longitude;
    latitude = _locationData.latitude;
  }
}
