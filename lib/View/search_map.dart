import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:time_alchemy_app/View/search.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';
import 'package:time_alchemy_app/logic/flutter/map_class.dart';
import 'package:time_alchemy_app/logic/flutter/search_map_b.dart';

//
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
  MapData? _mapData;
  // Changed to State<SearchMap>
  Completer<GoogleMapController> _controller =
      Completer(); // Added <GoogleMapController>

  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(35.17176088096857, 136.88817886263607),
    zoom: 14.4746,
  );

  Future<void> searchLocation(Map<String, dynamic> data) async {
    final GoogleMapController controller = await _controller.future;
    final double latitude = double.parse(data['latitude'].toString());
    final double longitude = double.parse(data['longitude'].toString());

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15,
    )));
    _mapData = MapData(latitude, longitude, data["placeName"]);
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    //final List<dynamic>? place =
    //    ModalRoute.of(context)?.settings.arguments as List<dynamic>?;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            compassEnabled: false,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Container(
            margin: EdgeInsets.only(bottom: screen.designW(16)),
            alignment: Alignment.bottomCenter,
            child: ChoiceButtonRed(
              text: '決定',
              onPressed: () {
                if (_mapData != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(mapData: _mapData)),
                  );
                }
              },
              height: 45,
              width: 150,
            ),
          ),
        ],
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
            await searchLocation(value);
          });
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
