import 'package:http/http.dart' as http;
import 'package:time_alchemy_app/View/Navigation.dart';
import 'package:time_alchemy_app/View/refine_search.dart';
import 'package:time_alchemy_app/component/menubar.dart';
import 'package:time_alchemy_app/logic/flutter/geolocation.dart';
import 'package:time_alchemy_app/logic/flutter/map_class.dart';
import 'package:time_alchemy_app/logic/flutter/time_conversion.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
// import '../env/env.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Add_destination(), // MyAppを直接指定
      ),
    );

class Add_destination extends StatelessWidget {
  Add_destination({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Add_destination_Page(),
    );
  }
}

class Add_destination_Page extends StatefulWidget {
  final MapData? mapData;
  final DateTime? selectedTime;
  Add_destination_Page({Key? key, this.mapData, this.selectedTime})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _Add_destination_Page();
}

class _Add_destination_Page extends State<Add_destination_Page> {
  final TextEditingController searchtextfieldcontroller =
      TextEditingController(); // 検索テキストフィールドのコントローラー
  // final API_KEY = Env.key; // APIキー(画像取得用)

  final List<Map<String, String?>> Navigation_List = []; //Navigation_Pageに渡すリスト
  List<Map<String, String?>> time_List = []; // 出発、到着、平均滞在時刻を格納するリスト

  Map<String, dynamic> _placesResponse = {}; // Places APIのレスポンスデータを格納するリスト
  Map<String, dynamic> _rootResponse = {}; // Directions APIのレスポンスデータを格納するリスト

  String _latitude = ''; // 緯度を格納する変数
  String _longitude = ''; // 経度を格納する変数
  String _average_stay_time = ''; // 平均滞在時間を格納する変数

  List<String> travel_time_List = []; //移動時間を格納するリスト
  List<String> _waypoints_List = []; // 経由地を格納するリスト

  List<bool> checkboxStates = []; // 各要素のチェックボックスの状態を管理するリスト
  bool _isHobby = false; // おすすめか趣味かを判定するフラグ
  bool _isNearbySearch = false; // リクエストが完了したかどうかを判定するフラグ
  // bool _isTextSearch = false;    // リクエスト完了したかどうかを判定するフラグ
  bool _isRequestOpenAI = false; // openAIにリクエストするかどうかを判定するフラグ

  final List<String> _recommend_tag = [
    'レストラン',
    'カフェ',
    'ラーメン',
  ];

  //test(次の予定の時間)
  DateTime _testtime = DateTime(2024, 2, 2, 12, 0, 00);

  //test(最終目的地)
  String _test_gole_latiude = '34.7051934134671';
  String _test_gole_longitude = '135.49840696016142';
  String _test_place_name = '梅田駅';

  //test(旅行の場合)
  final List<String> _hobby_tag = [
    '周辺の観光名所',
    'お土産におすすめのお店',
    '食べ歩きにおすすめ',
    '温泉地'
  ];

  // //test(ファッションの場合)
  // final List<String> _hobby_tag = [
  //   '洋服店',
  //   '靴屋',
  //   '古着',
  //   'アクセサリー店'
  // ];

  // //test(スポーツとバー巡りの場合)
  // final List<String> _hobby_tag = [
  //   'スポーツバー',
  //   'スポーツにおすすめなレジャー施設',
  //   'お酒の種類が豊富なバー',
  //   'スポーツ用品店'
  // ];

  @override
  void initState() {
    super.initState();
    print(widget.mapData);
    print(widget.selectedTime);
    // 初回時の現在地を取得
    // Future(() async {
    //   try{
    //     await _getCurrentLocation();
    //     await _nearbySearchRequest();
    //     checkboxStates = await List<bool>.filled(_placesResponse['places'].length, false); // チェックボックスの状態を初期化
    //   }catch(e){
    //       print('検索データがないよ:$e');
    //   }
    // });
  }

  // 現在地を取得する関数
  Future<void> _getCurrentLocation() async {
    try {
      // Geolocationインスタンス作成
      final geolocation = Geolocation();
      // 現在地取得
      final position = await geolocation.determinePosition();
      // 現在地の緯度経度を取得
      // _latitude = position.latitude.toString();
      // _longitude = position.longitude.toString();
      _latitude = "34.70647342120254";
      _longitude = "135.50323157772246";

      print('緯度: $_latitude 経度: $_longitude');
    } catch (error) {
      setState(() {
        print(error);
      });
    }
  }

  // Places API (nearbySearch)にリクエストするための関数
  Future<void> _nearbySearchRequest() async {
    try {
      // Places API (nearbySearch) にリクエスト
      final http.Response placesResponse = await http.get(Uri.parse(
          'http://IP:Port/current_nearbysearch?latitude=$_latitude&longitude=$_longitude'));

      setState(() {
        // 取得したデータを _placesResponse に代入
        _placesResponse = json.decode(placesResponse.body);
        checkboxStates = List<bool>.filled(
            _placesResponse['places'].length, false); // チェックボックスの状態を初期化
        _isNearbySearch = true;
      });
    } catch (error) {
      setState(() {
        print(error);
        _placesResponse = {};
      });
    }
  }

  // Places API (textSearch)にリクエストするための関数
  Future<void> _textSearchRequest(String text) async {
    try {
      // Places API (textSearch) にリクエスト
      final http.Response placesResponse = await http.get(Uri.parse(
          'http://IP:Port/current_textsearch?textQuery=$text&latitude=$_latitude&longitude=$_longitude'));

      setState(() {
        // 取得したデータを _placesResponse に代入
        _placesResponse = json.decode(placesResponse.body);
        checkboxStates = List<bool>.filled(
            _placesResponse['places'].length, false); // チェックボックスの状態を初期化
        // _isTextSearchをfalseに設定
        // _isTextSearch = true;
      });
    } catch (error) {
      setState(() {
        print(error);
        _placesResponse = {};
      });
    }
  }

  // Directions APIにリクエストするための関数
  Future<void> _directionsRequest() async {
    try {
      //到着時間を設定
      DateTime now = DateTime.now();
      //次の予定の到着時間をUTCに変換
      // String arrival_time_UTC = await widget.selectedTime!.toUtc().toIso8601String();
      //test
      DateTime arrival_time =
          await DateTime(now.year, now.month, now.day, 13, 0, 0).toUtc();
      //UTCに変換
      String arrival_time_UTC = await arrival_time.toUtc().toIso8601String();

      final http.Response directionsResponse = await http.get(Uri.parse(
          'http://IP:Port/current_places_root?origin=$_latitude,$_longitude&destination=$_test_gole_latiude,$_test_gole_longitude&waypoints=$_waypoints_List&arrival_time=$arrival_time_UTC'));

      setState(() {
        // 取得したデータを _placesResponse に代入
        _rootResponse = json.decode(directionsResponse.body);
      });
      // 取得した移動時間をtimeに格納
      for (int i = 0; i < _rootResponse['routes'][0]['legs'].length; i++) {
        travel_time_List
            .add(_rootResponse['routes'][0]['legs'][i]['duration']['text']);
      }
    } catch (error) {
      setState(() {
        print(error);
        _rootResponse = {};
      });
    }
  }

  //テキストの長さで改行する関数
  String _textWrap(String text, int line, int stop) {
    //line文字目で改行する
    //stop-3文字を超えたら...を表示する
    if (text.length > stop) {
      text = text.substring(0, stop - 3) + '...';
    }
    String result = '';
    while (text.length > line) {
      result += text.substring(0, line) + '\n';
      text = text.substring(line);
    }
    result += text;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    bool isIphone = MediaQuery.of(context).size.shortestSide > 320;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors_compornet.globalBackgroundColorwhite,
        ),
        actions: [
          Container(
            width: screen.designW(200),
            height: screen.designH(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:
                  Colors_compornet.globalBackgroundColorwhite.withOpacity(0.85),
            ),
            child: Center(
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isRequestOpenAI = false;
                        _isHobby = false;
                        Future(() async {
                          await _getCurrentLocation();
                          await _nearbySearchRequest();
                        });
                      });
                    },
                    child: Container(
                      width: screen.designW(100),
                      height: screen.designH(40),
                      decoration: BoxDecoration(
                        border: _isHobby == false
                            ? Border.all(
                                color:
                                    Colors_compornet.globalBackgroundColorRed)
                            : Border.all(
                                color: Colors_compornet
                                    .globalBackgroundColorwhite
                                    .withOpacity(0)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'おすすめ',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: _isHobby == false
                                  ? Colors_compornet.globalBackgroundColorRed
                                  : Colors_compornet.textfontcolorocher),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isRequestOpenAI = true;
                        _isHobby = true;
                        Future(() async {
                          await _getCurrentLocation();
                          // TODO:AI側へのリクエスト関数
                          await _getCurrentLocation();
                          await _textSearchRequest(_hobby_tag[0]); //test
                        });
                      });
                    },
                    child: Container(
                      width: screen.designW(100),
                      height: screen.designH(40),
                      decoration: BoxDecoration(
                        border: _isHobby == true
                            ? Border.all(
                                color:
                                    Colors_compornet.globalBackgroundColorRed)
                            : Border.all(
                                color: Colors_compornet
                                    .globalBackgroundColorwhite
                                    .withOpacity(0)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '趣味',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: _isHobby == true
                                  ? Colors_compornet.globalBackgroundColorRed
                                  : Colors_compornet.textfontcolorocher),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: screen.designW(100),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 画面全体をタップでキーボードを閉じる
        },
        child: Stack(
          children: [
            CustamBackgroundWidget(),
            Column(
              children: [
                SizedBox(height: screen.designH(4)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: screen.designW(16)),
                    // Container(
                    //    width: screen.designW(100),
                    //   height: screen.designH(30),
                    //   child: FilterClass(),
                    // ),

                    isIphone
                        ? SizedBox(width: screen.designW(50))
                        : SizedBox.shrink(),
                    // 絞り込みは最後に書いてます
                    SizedBox(width: screen.designW(16)),
                    SearchTextField(
                      hintText: '例：ラーメン',
                      height: screen.designH(30),
                      width: screen.designW(200),
                      controller: searchtextfieldcontroller,
                      onEditingComplete: (text) {
                        if (text.isNotEmpty) {
                          _textSearchRequest(text);
                        }
                      },
                    ),
                  ],
                ),
                //SizedBox(height: screen.designH(16)),
                Container(
                  height: screen.designH(50),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _isRequestOpenAI == true
                        ? _hobby_tag.length
                        : _recommend_tag.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String narrow_down_tag = _isRequestOpenAI == true
                          ? _hobby_tag[index]
                          : _recommend_tag[index];
                      return GestureDetector(
                        onTap: () {
                          _textSearchRequest(narrow_down_tag);
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors_compornet.textfontcolorocher,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            border: Border.all(
                              width: screen.designW(5),
                              color: Colors.transparent,
                            ),
                          ),
                          child: Center(
                              child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              '#$narrow_down_tag',
                              style: TextStyle(
                                color:
                                    Colors_compornet.globalBackgroundColorwhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          )),
                          alignment: Alignment.center, // テキストを中央に配置
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: screen.designH(110)),
              child: Column(
                children: [
                  //データがある時の処理
                  _isNearbySearch == true && _placesResponse.isNotEmpty
                      ? Container(
                          height: screen.designH(500), // 仮の高さ。必要に応じて調整してください。
                          child: ListView.builder(
                            itemCount: _placesResponse['places'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  if (_placesResponse['places'][index]
                                          ['websiteUri'] !=
                                      null) {
                                    launchUrl(
                                        Uri.parse(_placesResponse['places']
                                            [index]['websiteUri']),
                                        mode: LaunchMode.platformDefault,
                                        webOnlyWindowName: '_blank');
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'URLが存在しません',
                                      fontSize: 15,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.black,
                                    );
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: screen.designW(350),
                                      height: screen.designH(90),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors_compornet
                                            .globalBackgroundColorwhite
                                            .withOpacity(0.7),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            spreadRadius: 0.5,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: screen.designW(16)),
                                              SizedBox(
                                                width: screen.designW(85),
                                                height: screen.designH(75),
                                                // child: FittedBox(
                                                //   child: _placesResponse['places'][index]['photos'] != null
                                                //       ? Image.network(
                                                //           "https://places.googleapis.com/v1/${_placesResponse['places'][index]['photos'][0]['name']}/media?key=$API_KEY&max_height_px=150&max_width_px=150",
                                                //           fit: BoxFit.cover,
                                                //           width: screen.designW(85),
                                                //           height: screen.designH(75),
                                                //         )
                                                //       : Icon(
                                                //           Icons.no_photography,
                                                //           color: Colors_compornet.textfontColorBlack,
                                                //         ),
                                                // ),
                                              ),
                                              SizedBox(
                                                  width: screen.designW(16)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _textWrap(
                                                        _placesResponse['places']
                                                                    [index]
                                                                ['displayName']
                                                            ['text'],
                                                        12,
                                                        24),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors_compornet
                                                          .textfontColorBlack,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '評価:',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors_compornet
                                                              .textfontColorBlack,
                                                        ),
                                                      ),
                                                      _placesResponse['places']
                                                                      [index]
                                                                  ['rating'] !=
                                                              null
                                                          ? SizedBox(
                                                              height: screen
                                                                  .designH(16),
                                                              child: FittedBox(
                                                                child: Row(
                                                                  children: [
                                                                    if (_placesResponse['places'][index]
                                                                            [
                                                                            'rating'] !=
                                                                        null)
                                                                      // 評価の数だけ星を表示
                                                                      for (var i =
                                                                              0;
                                                                          i <
                                                                              _placesResponse['places'][index]['rating']
                                                                                  .floor();
                                                                          i++)
                                                                        const Icon(
                                                                            Icons
                                                                                .star,
                                                                            color:
                                                                                Colors.orange),
                                                                    if (_placesResponse['places'][index]
                                                                            [
                                                                            'rating'] !=
                                                                        null)
                                                                      // 評価の数が5に満たない場合、星の枠を表示
                                                                      for (var j =
                                                                              0;
                                                                          j <
                                                                              5 -
                                                                                  _placesResponse['places'][index]['rating']
                                                                                      .floor();
                                                                          j++)
                                                                        const Icon(
                                                                            Icons
                                                                                .star_border,
                                                                            color:
                                                                                Colors.orange),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Text(
                                                              'なし',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors_compornet
                                                                    .textfontColorBlack,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            right: screen.designW(10),
                                            top: screen.designH(20),
                                            child: Transform.scale(
                                              scale: 1.5,
                                              child: Checkbox(
                                                value: checkboxStates[index],
                                                onChanged: (value) {
                                                  setState(() {
                                                    checkboxStates[index] =
                                                        value!;
                                                    if (checkboxStates[index] ==
                                                        true) {
                                                      _waypoints_List.add(
                                                          _placesResponse['places']
                                                                      [index][
                                                                  'displayName']
                                                              ['text']);
                                                    } else {
                                                      _waypoints_List.remove(
                                                          _placesResponse['places']
                                                                      [index][
                                                                  'displayName']
                                                              ['text']);
                                                    }
                                                    print(_waypoints_List);
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: screen.designH(16)),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      //データがない時の処理
                      : Center(
                          child: Column(
                            children: [
                              SizedBox(height: screen.designH(200)),
                              Text(
                                'データがありません',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors_compornet.textfontColorBlack,
                                ),
                              ),
                              SizedBox(height: screen.designH(16)),
                              Text(
                                '検索条件を変更してください',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors_compornet.textfontColorBlack,
                                ),
                              ),
                              SizedBox(
                                height: screen.designH(16),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ChoiceButtonRed(
                                  text: '更新',
                                  onPressed: () {
                                    //追加を押した時の処理
                                    Future(() async {
                                      await _getCurrentLocation(); //test
                                      // await _nearbySearchRequest();   //test
                                    });
                                  },
                                  width: 140, //140
                                  height: 50, //50
                                ),
                              )
                            ],
                          ),
                        ),
                  SizedBox(height: screen.designH(16)),
                  if (_placesResponse.isNotEmpty)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ChoiceButtonRed(
                        text: '追加',
                        onPressed: () {
                          //追加を押した時の処理
                          Future(() async {
                            //追加したい場所のルートをと移動時間を取得
                            await _directionsRequest();
                            //出発、到着、平均滞在時刻を取得
                            time_List = await Time_Conversion().convertTime(
                                DateTime.now(), travel_time_List, _testtime);

                            // Navigation_Listに経由地の名、到着、出発時刻を格納
                            for (int i = 0; i <= time_List.length - 1; i++) {
                              if (i == time_List.length - 1) {
                                Navigation_List.add({
                                  'name': _test_place_name,
                                  'arrival_time': time_List[i]['arrival_time'],
                                  'departure_time': time_List[i]
                                      ['departure_time'],
                                });
                                _average_stay_time = time_List[i]
                                        ['average_stay_time']
                                    .toString();
                              } else {
                                Navigation_List.add({
                                  'name': _waypoints_List[i],
                                  'arrival_time': time_List[i]['arrival_time'],
                                  'departure_time': time_List[i]
                                      ['departure_time'],
                                });
                              }
                            }
                            // Navigation_Pageに遷移
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Navigation_Page(
                                  Navigation_List:
                                      Navigation_List, // 経由地の名、到着、出発時刻を格納したリスト
                                  average_stay_time:
                                      _average_stay_time, // 平均滞在時間
                                ),
                              ),
                            );
                          });
                        },
                        width: 140, //140
                        height: 50, //50
                      ),
                    )
                ],
              ),
            ),
            FilterClass(),
            Align(
            alignment: Alignment.bottomRight,
            child: ClockMenu(),
            ),
          ],
        ),
      ),
    );
  }
}
