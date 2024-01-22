import 'dart:math';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/Dashed_Line.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';
import 'package:intl/intl.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Navigation(), // MyAppを直接指定
      ),
    );

class Navigation extends StatelessWidget {
  Navigation({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Navigation_Page(),
    );
  }
}

class Navigation_Page extends StatefulWidget {
  Navigation_Page({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Navigation_Page();
}

class _Navigation_Page extends State<Navigation_Page> {
  String now_time =
      DateFormat('HH:mm').format(DateTime.now()).toString(); //現在時刻

  // 現在の時刻を更新するメソッド
  void updateCurrentTime() {
    setState(() {
      now_time = DateFormat('HH:mm').format(DateTime.now());
    });
  }

  //テストでーた
  final List<Map<String, String?>> destination = [
    {
      'label': '大阪駅',
      'arrival_time': '11:45',
      'departure_time': '15:00',
      'staying time':'15',
    },
    {
      'label': '福島駅',
      'arrival_time': '11:53',
      'departure_time': '11:55',
      'staying time' :'2',
    },
    {
      'label': '西九条駅',
      'arrival_time': '11:58',
      'departure_time': '12:04',
      'staying time':'6'
    },
    {
      'label': 'ユニバーサルシティ駅',
      'arrival_time': '12:09',
      'departure_time': '12:11',
      'staying time':'2'
    },
    {
      'label': 'ユニバーサルスタジオジャパン',
      'arrival_time': '12:16',
      'departure_time': null,
      'staying time':null
    },
  ];
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      appBar: AppBarWhiteTextCompornent(
        title: 'TimeAlchemy',
        rightText: '次へ',
        onPressedLeft: () => {},
        onPressedRight: () => {},
        showRightText: false, //右の
      ),
      body: Stack(
        children: [
          BackgroundWidget(),
          Padding(
            padding: EdgeInsets.only(top: screen.designH(120)),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: screen.designH(64),
                      decoration: BoxDecoration(
                          color: Colors_compornet.textfontColorWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screen.designW(10),
                          ),
                          Text(
                            '${now_time}発',
                            style: TextStyle(
                                color:
                                    Colors_compornet.globalBackgroundColorRed,
                                fontSize: screen.designH(16),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: screen.designW(8),),
                          Icon(
                            Icons.directions_run,
                            size: screen.designW(45),
                          ),

                          //ボタンだった場合の処理
                          ElevatedButton(
                            onPressed: () {
                              //現在地を押された時の処理
                              updateCurrentTime(); // 現在の時刻を更新
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // 背景色を透明にする
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '現在地',
                                  style: TextStyle(
                                      color: Colors_compornet
                                          .globalBackgroundColorRed,
                                      fontSize: screen.designH(20),
                                      fontWeight: FontWeight.bold),
                                ), // テキスト
                                SizedBox(
                                    width: screen.designW(2)), // アイコンとテキストの間隔
                                Icon(
                                  Icons.chevron_right,
                                  color:
                                      Colors_compornet.globalBackgroundColorRed,
                                  size: screen.designH(30),
                                ),
                              ],
                            ),
                          ),
                          //テキストだった場合の処理
                          // Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     Text('現在地',
                          //       style: TextStyle(
                          //         color: Colors_compornet.globalBackgroundColorRed,
                          //         fontSize: screen.designH(20),
                          //         fontWeight: FontWeight.bold
                          //       ),
                          //     ), // テキスト
                          //     SizedBox(width: screen.designW(2)), // アイコンとテキストの間隔
                          //     Icon(Icons.chevron_right,
                          //     color: Colors_compornet.globalBackgroundColorRed,
                          //     size: screen.designH(30),),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: destination.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Map<String, String?> destinationData =
                              destination[index];
                          final String label = destinationData['label'] ?? '';
                          final String? arrivalTime =
                              destinationData['arrival_time'];
                          final String? departureTime =
                              destinationData['departure_time'];
                          final String? stayingtime = destinationData['staying time'];
                              

                          return Column(
                            children: [
                              SizedBox(
                                height: screen.designH(120),
                              ),
                              Container(
                                  width: double.infinity,
                                  height: screen.designH(64),
                                  decoration: BoxDecoration(
                                    color: Colors_compornet.textfontColorWhite,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: screen.designW(10),
                                      ),
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center, // 垂直方向の中央揃え
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$arrivalTime着',
                                              style: TextStyle(
                                                  color: Colors_compornet
                                                      .textfontColorBlack,
                                                  fontSize: screen.designH(16),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: screen.designH(3),
                                            ),
                                            if (departureTime != null)
                                              Text(
                                                '$departureTime発',
                                                style: TextStyle(
                                                    color: Colors_compornet
                                                        .globalBackgroundColorRed,
                                                    fontSize:
                                                        screen.designH(16),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                          ]),
                                          SizedBox(width: screen.designW(48),),
                                      ElevatedButton(
                                        onPressed: () {
                                          // 現在地を押された時の処理
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.transparent, // 背景色を透明にする
                                          elevation: 0,
                                          padding:
                                              EdgeInsets.zero, // パディングを無効にする
                                          minimumSize:
                                              Size(0, 0), // 最小サイズを無効にする
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '$label',
                                              style: TextStyle(
                                                color: Colors_compornet
                                                    .globalBackgroundColorRed,
                                                fontSize: label.length > 8
                                                    ? screen.designW(13)
                                                    : screen.designW(20),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1, // オーバーフローした場合の動作を指定
                                            ),
                                            // アイコンとテキストの間隔
                                            Icon(
                                              Icons.chevron_right,
                                              color: Colors_compornet
                                                  .globalBackgroundColorRed,
                                              size: screen.designH(30),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        color: Colors_compornet.globalBackgroundColorRed,
                                        iconSize: screen.designH(30),
                                        onPressed: () { 
                                          //ここでsearch.dartにページ遷移するかAdd destination.dartに遷移する処理を書く
                                          if(departureTime ==null){
                                            //ここにsearch.dartにページ遷移するコード
                                          }else{
                                            //ここにAdd destination.dartにページ遷移するコードを書く

                                          }
                                        }, 
                                        icon:Icon(Icons.location_on),
                                      ),
                                      if(stayingtime!=null)
                                      Align(
                                        alignment: Alignment.centerRight,
                                         child: Container(//以下を入れる
                                          height: screen.designH(40),
                                          width: screen.designW(40),
                                          decoration:  BoxDecoration(
                                            color: Colors_compornet.textfontColorWhite,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors_compornet.globalBackgroundColorRed),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: screen.designH(3),),
                                              Text(
                                                '滞在時間',
                                                style: TextStyle(
                                                    fontSize: screen.designW(7),
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              SizedBox(height: screen.designH(1),),
                                              Text(
                                                '$stayingtime分',
                                                style: TextStyle(
                                                  color: Colors_compornet.staytime,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ),
                            ],
                          );
                        }
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Stack(
          //   alignment: Alignment.topLeft,
          //   children: [
          //     //時系列線

          //     Align(
          //       alignment: Alignment(-0.5,-01),
          //       child: Dashed_Line(
          //         height: double.infinity,
          //         width: screen.designW(4), // Dashed_Line の幅を変更
          //       ),
          //     ),
          //     // ↓アイコンと〇図形
              
          //   ],
          // ),
        ],
      ),
    );
  }
}
