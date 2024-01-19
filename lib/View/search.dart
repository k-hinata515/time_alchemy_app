import 'dart:math';

import 'package:device_preview/device_preview.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/Dashed_Line.dart';
import 'package:time_alchemy_app/component/IconButton.dart';
import 'package:time_alchemy_app/component/ToggleButton.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Search(), // Wrap your app
      ),
    );

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  State<StatefulWidget> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  String now_time =
      DateFormat('HH:mm').format(DateTime.now()).toString(); //現在時刻
  final TextEditingController destination_controller = TextEditingController();
  final TextEditingController _next_destinationController =
      TextEditingController();
  void showFilterInOrOut() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String next_destination = '';
    final screen = ScreenRef(context).watch(screenProvider);
    return Scaffold(
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      appBar: AppBarWhiteTextCompornent(
        title: 'TimeAlchemy',
        rightText: '次へ',
        onPressedLeft: () => {},
        onPressedRight: () => {},
        showRightText: false, //次へ
      ),
      body: Stack(
        children: [
          BackgroundWidget(),
          Center(
            child: Row(
              children: [
                SizedBox(
                  width: screen.designW(16),
                ),
                //現在時刻取得
                Padding(
                  padding: EdgeInsets.only(top: screen.designH(75)),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment(0, -0.63),
                        child: Text(
                          now_time,
                          style: TextStyle(
                            color: Colors_compornet.globalBackgroundColorRed,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      //スペース
                      SizedBox(
                        width: screen.designW(16),
                      ),
                      //時系列線
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment(0, -0.5),
                            child: Dashed_Line(
                              height: screen.designH(350),
                              width: screen.designW(2), // Dashed_Line の幅を変更
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, -0.65),
                            child: Container(
                              width: screen.designW(36),
                              height: screen.designH(36),
                              decoration: BoxDecoration(
                                color: Colors_compornet.navigation_icon,
                                shape: BoxShape.circle,
                              ),
                              child: Transform.rotate(
                                angle: 180 * pi / 180, // 180°回転
                                child: Icon(
                                  color:
                                      Colors_compornet.globalBackgroundColorRed,
                                  Icons.navigation,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                //現在地
                Padding(
                  padding: EdgeInsets.only(top: screen.designH(190)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormButton(
                        height: 40,
                        width: 220,
                        labelText: '現在地',
                        exampletext: '中崎町',
                      ),
                      SizedBox(height: screen.designH(45)),
                      Container(
                        height: screen.designH(175),
                        width: screen.designW(260),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors_compornet
                                .globalBackgroundColorRed, // 枠線の色
                            width: 2.0, // 枠線の太さ
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // 他のウィジェットをここに追加
                        child: Column(
                          children: [
                            SizedBox(
                              height: screen.designH(20),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: screen.designW(20),
                                ),
                                MyTextFormField(
                                  labelText: '次の目的地',
                                  height: 30,
                                  width: 180,
                                  controller: destination_controller,
                                  obscuretext: false,
                                ),
                                SizedBox(
                                  width: screen.designW(3),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // マップアイコンを押した時の処理をここに記述
                                  },
                                  icon: Icon(
                                    Icons.add_location_alt,
                                    color: Colors_compornet
                                        .globalBackgroundColorRed,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screen.designH(5),
                            ),
                            TimePickerSample(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screen.designH(100),
                      ),
                      ChoiceButtonRed(
                        height: 250,
                        width: 45,
                        text: '検索',
                        onPressed: () {
                          print(_next_destinationController.text);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screen.designH(20), // 下方向の位置
            right: screen.designH(20), // 右方向の位置
            child: MapIconButton(
              onPressed: () {
                // MapIconButton が押されたときの処理
                print('Map Icon Button Pressed');
              },
              width: screen.designW(20),
              height: screen.designH(20),
            ),
          ),
        ],
      ),
    );
  }
}

class TimePickerSample extends StatefulWidget {
  TimePickerSample({Key? key}) : super(key: key);

  @override
  _TimePickerSampleState createState() => _TimePickerSampleState();
}

class _TimePickerSampleState extends State<TimePickerSample> {
  TimeOfDay? selectedTime;
  String now_time =
      DateFormat('HH:mm').format(DateTime.now()).toString(); //現在時刻
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "次の予定の到着時間",
          style: TextStyle(
            fontSize: 12,
            color: Colors_compornet.textfontcolorocher,
          ),
        ),
        SizedBox(
          height: screen.height * 0.002,
        ),
        ElevatedButton(
          //到着時間選択
          onPressed: () => _pickTime(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors_compornet.textfontColorWhite,
            onPrimary: Colors_compornet.globalBackgroundColorRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            side: BorderSide(
              color: Colors_compornet.globalBackgroundColorRed,
              width: 2.0,
            ),
            padding: EdgeInsets.symmetric(
              vertical: screen.height * 0.01,
              horizontal: screen.width * 0.02,
            ), // パディングを設定
            minimumSize: Size(
              screen.width * 0.55,
              screen.height * 0.05,
            ), // 最小サイズを設定
          ),
          child: Text(
            selectedTime != null
                ? "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}"
                : "$now_time",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Future _pickTime(BuildContext context) async {
    // デフォルトの初期時間を設定
    final now = DateTime.now();
    final initialTime = TimeOfDay.fromDateTime(now);

    // showTimePickerを呼び出し、ユーザーが新しい時間を選択するのを待機
    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);

    // ユーザーが時間を選択した場合
    if (newTime != null) {
      // 選択された時間を状態にセットして、画面を再描画
      setState(() => selectedTime = newTime);
    } else {
      // キャンセルされた場合は何もせずに処理を終了
      return;
    }
  }
}
