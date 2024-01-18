import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:time_alchemy_app/logic/flutter/googlemap_b.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapScreen(),
    );
  }
}

// Googleマップを含むメイン画面のウィジェット
class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

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
          return GoogleMapWidget(initialPosition: initialPosition);
        }
      },
    );
  }
}

// Googleマップのためのウィジェット
class GoogleMapWidget extends StatefulWidget {
  final Position? initialPosition;

  const GoogleMapWidget({Key? key, this.initialPosition}) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState(initialPosition);
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController _controller;

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
    // 現在の位置を連続的に更新するための位置ストリームをセットアップ
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
    return GoogleMap(
      // Googleマップのプロパティを構成
      mapType: MapType.normal,
      initialCameraPosition: _initialCameraPosition,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
    );
  }
}
