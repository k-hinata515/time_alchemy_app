import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:time_alchemy_app/component/menubar.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';
import 'package:time_alchemy_app/logic/flutter/googlemap_b.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp()), // Wrap your app
    
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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
  final data = [
    'assets/logo_images/ECCcanpas.png',
    'assets/logo_images/daisensou.png',
    'assets/logo_images/osakastation.png',
    'assets/logo_images/rinkutownstation.png',
    'assets/logo_images/mcdnald.png'
  ];
  final label = [
    
    'ECCコンピュータ専門学校',
    'ラーメン大戦争',
    '大阪駅',
    'りんくうタウン駅',
    'マクドナルド'
  ];

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
    final screen = ScreenRef(context).watch(screenProvider);
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
        },
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
              SizedBox(width:screen.designW(4)),
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
                      color: Colors_compornet.globalBackgroundColorwhite,
                      fontSize: screen.designW(15)
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: screen.designH(3),
                          width: screen.designW(70),
                          color: Colors_compornet.globalBackgroundColorRed,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors_compornet.globalBackgroundColorRed,
                        ),
                        Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: screen.designW(60),
                              height: screen.designH(50),
                              child: FittedBox(
                                fit:BoxFit.contain ,
                              child: Image.asset(
                                data[index],
                              ),
                            ),
                            ),
                            
                        Text(
                          label[index],
                          style: TextStyle(
                            color: Colors_compornet.textfontcolorocher,
                            fontSize: label[index].length > 7
                                ? screen.designH(8)
                                : screen.designH(12),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                          ],
                        )
                        ),
                        SizedBox(width: screen.designW(8),)
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
    padding: EdgeInsets.only(right: screen.designH(45.0) ), // 上方向のパディングを追加
    child: ClockMenu(),
  ),
),


    ],
  ),
);

  }
}