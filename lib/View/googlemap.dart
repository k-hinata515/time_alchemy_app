import 'dart:math';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:time_alchemy_app/component/menubar.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';
import 'package:time_alchemy_app/env/env.dart';
import 'package:time_alchemy_app/logic/flutter/googlemap_b.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() => runApp(
      DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => MyApp()), // Wrap your app
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
      home: MapScreen(),
    );
  }
}

// Googleマップを含むメイン画面のウィジェット
class MapScreen extends StatelessWidget {
  final List<Map<String, String?>>? navigationList;
  final List<List<double>>? waypointsLocationList;
  final List<String>? photo_name_List;
  const MapScreen(
      {Key? key,
      this.navigationList,
      this.waypointsLocationList,
      this.photo_name_List})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // 現在の位置を非同期で取得
      future: MapLogic.getCurrentLocation(),
      builder: (context, AsyncSnapshot<Position?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 位置データを待っている間にローディングインジケータを表示
          return CircularProgressIndicator();
        } else {
          // 位置データが利用可能になったらGoogleマップを表示
          Position? initialPosition = snapshot.data;
          return GoogleMapWidget(
              initialPosition: initialPosition,
              navigationList: navigationList,
              waypointsLocationList: waypointsLocationList,
              photo_name_List: photo_name_List);
        }
      },
    );
  }
}

// Googleマップのためのウィジェット
class GoogleMapWidget extends StatefulWidget {
  final Position? initialPosition;
  final List<Map<String, String?>>? navigationList;
  final List<List<double>>? waypointsLocationList;
  final List<String>? photo_name_List;

  const GoogleMapWidget(
      {Key? key,
      this.initialPosition,
      this.navigationList,
      this.waypointsLocationList,
      this.photo_name_List})
      : super(key: key);

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState(initialPosition);
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController _controller;
  final API_KEY = Env.key;
  Set<Marker> markers = {}; // Define markers set
  List<String>? data; // data変数を定義
  final label = [];

  List<double> get nextLatitudes {
    if (widget.waypointsLocationList != null) {
      return widget.waypointsLocationList!
          .map<double>((waypoint) => waypoint[0])
          .toList();
    }
    return [];
  }

  List<double> get nextLongitudes {
    if (widget.waypointsLocationList != null) {
      return widget.waypointsLocationList!
          .map<double>((waypoint) => waypoint[1])
          .toList();
    }
    return [];
  }

  late PolylinePoints _polylinePoints;
  Map<PolylineId, Polyline> polylines = {};

  // Googleマップの初期カメラ位置を現在位置に設定
  CameraPosition get _initialCameraPosition {
    return CameraPosition(
      target: LatLng(
        widget.initialPosition?.latitude ?? 0.0,
        widget.initialPosition?.longitude ?? 0.0,
      ),
      zoom: 14,
    );
  }

  Position? currentPosition;

  // 初期位置で状態を初期化するためのコンストラクタ
  GoogleMapWidgetState(Position? initialPosition) {
    currentPosition = initialPosition;
  }

  @override
  void initState() {
    super.initState();
    // _polylinePointsを先に初期化
    _polylinePoints = PolylinePoints();
    addMarkers(); // マーカーを追加
    data = widget.photo_name_List; // data変数に値を代入
    // 他の初期化コードはそのまま
    LocationStream.getPositionStream(
      const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
      (Position? position) {
        setState(() {
          currentPosition = position;
          print(position == null
              ? 'Unknown'
              : '${position.latitude.toString()}, ${position.longitude.toString()}');
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    print(API_KEY);
    return Scaffold(
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      body: Stack(
        children: [
          GoogleMap(
            // Googleマップのプロパティを構成
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              // マーカーを追加
              addMarkers();
            },
            polylines: Set<Polyline>.of(polylines.values),
          ),
          Column(
            children: [
              Container(
                height: screen.designH(40),
                width: double.infinity,
                color: Colors_compornet.globalBackgroundColorRed,
              ),
              Container(
                height: screen.designH(95),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors_compornet.globalBackgroundColorwhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: screen.designW(4)),
                      Container(
                        height: screen.designH(45),
                        width: screen.designW(75),
                        decoration: BoxDecoration(
                          color: Colors_compornet.globalBackgroundColorRed,
                        ),
                        child: Center(
                          child: Text(
                            '現在地',
                            style: TextStyle(
                                color:
                                    Colors_compornet.globalBackgroundColorwhite,
                                fontSize: screen.designW(15)),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: screen.designH(3),
                                  width: screen.designW(70),
                                  color:
                                      Colors_compornet.globalBackgroundColorRed,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color:
                                      Colors_compornet.globalBackgroundColorRed,
                                ),
                                Container(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: screen.designW(60),
                                      height: screen.designH(50),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: FittedBox(
                                            child: Image.network(
                                          "https://places.googleapis.com/v1/${data?[index]}/media?key=$API_KEY&max_height_px=150&max_width_px=150",
                                          fit: BoxFit.cover,
                                          width: screen.designW(85),
                                          height: screen.designH(75),
                                        )),
                                      ),
                                    ),
                                    Text(
                                      label[index],
                                      style: TextStyle(
                                        color:
                                            Colors_compornet.textfontcolorocher,
                                        fontSize: label[index].length > 7
                                            ? screen.designH(8)
                                            : screen.designH(12),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  width: screen.designW(8),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(right: screen.designH(45.0)), // 上方向のパディングを追加
              child: ClockMenu(),
            ),
          ),
        ],
      ),
    );
  }

  void addMarkers() {
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId('currentPosition'),
        position: LatLng(
          currentPosition?.latitude ?? 0.0,
          currentPosition?.longitude ?? 0.0,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    for (int i = 0; i < nextLatitudes.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('nextPosition_$i'),
          position: LatLng(
            nextLatitudes[i],
            nextLongitudes[i],
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    setState(() {});
    drawRoutes();
  }

  void drawRoutes() async {
    polylines.clear();
    final random = Random();
    List<LatLng> allCoordinates = [
      LatLng(currentPosition!.latitude, currentPosition!.longitude),
      for (int i = 0; i < nextLatitudes.length; i++)
        LatLng(nextLatitudes[i], nextLongitudes[i]),
    ];

    for (int i = 0; i < allCoordinates.length - 1; i++) {
      List<LatLng> polylineCoordinates = [];
      PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
        '$API_KEY',
        PointLatLng(
          allCoordinates[i].latitude,
          allCoordinates[i].longitude,
        ),
        PointLatLng(
          allCoordinates[i + 1].latitude,
          allCoordinates[i + 1].longitude,
        ),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }

      PolylineId id = PolylineId('route_$i');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Color.fromARGB(255, random.nextInt(256), random.nextInt(256),
            random.nextInt(256)), // Random color
        points: polylineCoordinates,
        width: 3,
      );
      setState(() {
        polylines[id] = polyline;
      });
    }
  }
}
