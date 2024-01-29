import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:time_alchemy_app/View/search.dart';
import 'package:time_alchemy_app/logic/flutter/search_map_b.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Google Maps Demo',
      home: SearchMap(), // Changed to SearchMap
    );
  }
}

class SearchMap extends StatefulWidget {
  // Changed to StatefulWidget
  const SearchMap({Key? key}) : super(key: key);

  @override
  _SearchMapState createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {
  // Changed to State<SearchMap>
  Completer<GoogleMapController> _controller =
      Completer(); // Added <GoogleMapController>

  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(35.17176088096857, 136.88817886263607),
    zoom: 14.4746,
  );

  Future<void> searchLocation(List result) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target:
          LatLng(result[0], result[1]), // CameraPositionのtargetに経度・緯度の順で指定します。
      zoom: 15,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        compassEnabled: false,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          // Added GoogleMapController type
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Search_Map_Page();
              },
            ),
          ).then((value) async {
            // valueに配列に格納された経度・緯度が格納されています
            await searchLocation(value);
          });
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
