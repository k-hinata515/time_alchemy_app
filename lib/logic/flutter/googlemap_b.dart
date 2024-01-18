import 'dart:async';
import 'package:geolocator/geolocator.dart';

class MapLogic {
  static Future<Position?> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}

class LocationStream {
  static StreamSubscription<Position> getPositionStream(
      LocationSettings locationSettings,
      void Function(Position? position) onPositionUpdate) {
    return Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen(onPositionUpdate);
  }
}
