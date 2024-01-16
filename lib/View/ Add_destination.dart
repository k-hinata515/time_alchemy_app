import 'package:http/http.dart' as http;
import 'dart:convert';
import '../env/env.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  Add_destination_Page({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Add_destination_Page();
}

class _Add_destination_Page extends State<Add_destination_Page> {
  final TextEditingController searchtextfieldcontroller = TextEditingController();
  final API_KEY = Env.key; // APIキー
  Map<String, dynamic> _placesResponse = {}; // Places APIのレスポンスデータを格納するList
  // List<dynamic> _place_photo = [];
  bool _isNearbySearch = false;    // リクエスト中かどうかを判定するフラグ
  bool _isTextSearch = false;    // リクエスト中かどうかを判定するフラグ

  //test
  final List<String> narrow_down = [
    '評価順',
    'ランチ',
    '価格が低い',
  ];

  @override
  void initState() {
    super.initState();
    // _nearbySearchRequest();
  }
  

  // Places API (nearbySearch)にリクエストするための関数
  Future<void> _nearbySearchRequest() async {
    try {
      final lat = 34.7055051;
      final lon = 135.4983028;
      
      print('緯度:$lat''経度:$lon');

      // Places API (nearbySearch) にリクエスト
      final http.Response placesResponse = await http.get(
          Uri.parse('http://192.168.11.10:5000/current_nearbysearch?latitude=$lat&longitude=$lon'));

      setState(() {
        // 取得したデータを _placesResponse に代入
        _placesResponse = json.decode(placesResponse.body);
        // _isSearchをfalseに設定
        _isNearbySearch = true;
      });

    } catch (error) {
      setState(() {
        print(error);
        _placesResponse = {};
        // _isSearchをfalseに設定
        _isNearbySearch = true;
      });
    }
  }         

    // Places API (nearbySearch)にリクエストするための関数
  Future<void> _textSearchRequest(String text) async {
    try {
      //TODO:位置情報取得処理
      //test
      final lat = 34.7055051;
      final lon = 135.4983028;
      
      print('緯度:$lat''経度:$lon');

      // Places API (textSearch) にリクエスト

      final http.Response placesResponse = await http.get(
          Uri.parse('http://192.168.11.10:5000/current_textsearch?&textQuery=$text&latitude=$lat&longitude=$lon'));

      setState(() {
        // 取得したデータを _placesResponse に代入
        _placesResponse = json.decode(placesResponse.body);
        // _isSearchをfalseに設定
        _isTextSearch = true;
      });

    } catch (error) {
      setState(() {
        print(error);
        _placesResponse = {};
        // _isSearchをfalseに設定
        _isTextSearch = true;
      });
    }
  }  

  //テキストの長さで改行する関数
  String _textWrap(String text,  int line , int stop) {
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
    bool  is_Checked = false; //チェックボックスの状態管理 
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
            height: screen.designH(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors_compornet.globalBackgroundColorwhite.withOpacity(0.85),
            ),
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: TabBar(
                unselectedLabelColor: Colors_compornet.textfontColorBlack,
                labelColor: Colors_compornet.globalBackgroundColorRed,
                indicator: BoxDecoration(
                  border: Border.all(color: Colors_compornet.textfontColorBlack),
                  borderRadius: BorderRadius.circular(12),
                ),
                tabs: <Widget>[
                  GestureDetector(
                    child:Tab(
                      text: 'おすすめ',
                    ),
                    onTap: () {
                      _nearbySearchRequest();
                    },
                  ),
                  GestureDetector(
                    child:Tab(
                      text: '趣味',
                    ),
                    onTap: () {
                      //TODO:AI側へのリクエスト処理
                    },
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
        child:Stack(
          children: [
            CustamBackgroundWidget(),
            Column(
              children: [
                SizedBox(height: screen.designH(4)),
                Row(
                  children: [
                    SizedBox(width: screen.designW(16)),
                    Container(
                      // width: screen.designW(100),
                      height: screen.designH(30),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.reorder,
                          size: 12,
                        ),
                        label: Text(
                          '絞り込み',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 12),
                          backgroundColor: Colors_compornet.narrow_down,
                          side: BorderSide(color: Colors_compornet.globalBackgroundColorwhite),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screen.designW(16)),
                    SearchTextField(
                      hintText: '例：ラーメン',
                      height: screen.designH(30),
                      width: screen.designW(200),
                      controller: searchtextfieldcontroller,
                      onEditingComplete: (text) {
                        if (text.isNotEmpty) {
                          // _textSearchRequest(text);
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
                    itemCount: narrow_down.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String narrow_down_tag = narrow_down[index];
                      return Container(
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
                          child : FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                            '#$narrow_down_tag',
                            style: TextStyle(
                              color: Colors_compornet.globalBackgroundColorwhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          )
                          
                        ),
                        alignment: Alignment.center, // テキストを中央に配置
                      );
                    },
                  ),
                ),
              ],
            ),
  //ここから          
            Padding(
              padding: EdgeInsets.only(top: screen.designH(110)),
              child: Column(
                children: [
                  if(_isNearbySearch == true)
                  Container(
                    height: screen.designH(500), // 仮の高さ。必要に応じて調整してください。
                    child: ListView.builder(
                      itemCount: _placesResponse['places'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              width: screen.designW(350),
                              height: screen.designH(90),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors_compornet.globalBackgroundColorwhite.withOpacity(0.7),
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
                                      SizedBox(width: screen.designW(16)),
                                      SizedBox(
                                        width: screen.designW(85),
                                        height: screen.designH(75),
                                        child: FittedBox(
                                          child: _placesResponse['places'][index]['photos'] != null
                                              ? Image.network(
                                                  "https://places.googleapis.com/v1/${_placesResponse['places'][index]['photos'][0]['name']}/media?key=$API_KEY&max_height_px=150&max_width_px=150",
                                                  fit: BoxFit.cover,
                                                  width: screen.designW(85),
                                                  height: screen.designH(75),
                                                )
                                              : Icon(
                                                  Icons.no_photography,
                                                  color: Colors_compornet.textfontColorBlack,
                                                ),
                                        ),
                                      ),
                                      SizedBox(width: screen.designW(16)),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                                _textWrap(_placesResponse['places'][index]['displayName']['text'], 12 , 24),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors_compornet.textfontColorBlack,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '評価:',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors_compornet.textfontColorBlack,
                                                ),
                                              ),
                                              _placesResponse['places'][index]['rating'] != null
                                                  ? SizedBox(
                                                      height: screen.designH(16),
                                                      child: FittedBox(
                                                        child: RatingBar.builder(
                                                          initialRating: _placesResponse['places'][index]['rating'].toDouble(),
                                                          itemBuilder: (context, index) => Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          allowHalfRating: true,
                                                          onRatingUpdate: (rating) {},
                                                          itemCount: 5,
                                                        ),
                                                      ),
                                                    )
                                                  : Text(
                                                      'なし',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors_compornet.textfontColorBlack,
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
                                        value: is_Checked,
                                        onChanged: (value) {
                                          setState(() {
                                            is_Checked = value!;
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
                        );
                      },
                    ),
                  ),                
                  //ここまで            
                  SizedBox(height: screen.designH(16),),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ChoiceButtonRed(
                      text: '追加',
                      onPressed: (){
                        //追加を押した時の処理
                      },
                      height: 150,    //50  
                      width: 50,      //140
                    ),
                  )
                ],
              ),
            ),     
          ],
        ),
      ),
    );
  }
}