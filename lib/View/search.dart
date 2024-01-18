import 'dart:math';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/Dashed_Line.dart';
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
  String now_time = DateFormat('HH:mm').format(DateTime.now()).toString();  //現在時刻
  final TextEditingController _next_destinationController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    String next_destination = '';
    final screen = ScreenRef(context).watch(screenProvider);
    return MaterialApp(
      home: Scaffold(
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
                    SizedBox(width: screen.designW(16),),
                    //現在時刻取得
                    Align(
                      alignment: Alignment(0,-0.63),
                     child:Text(
                      now_time,
                      style: TextStyle(
                        color: Colors_compornet.globalBackgroundColorRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                    ),
                    ),
                    //スペース
                    SizedBox(width:screen.designW(16),),
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
                                color:Colors_compornet.globalBackgroundColorRed,
                                Icons.navigation,
                               
                              ),
                            ),
                          ), 
                        )
                        
                      ],
                    ),

                    
                    //現在地
                    Padding(
                       padding: EdgeInsets.only(top: screen.designH(100)),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormButton(
                          height: screen.designH(45),
                          width: screen.designW(200),
                          labelText: '現在地',
                          exampletext: '中崎町',
                        ),
                        SizedBox(height: screen.designH(16)),
                        Container(
                          height: screen.designH(200),
                          width: screen.designW(280),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors_compornet.globalBackgroundColorRed, // 枠線の色
                              width: 2.0, // 枠線の太さ
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // 他のウィジェットをここに追加
                          child:  Column(
                            children: [
                              SizedBox(height: screen.designH(16),),
                              MyTextFormField(
                                obscuretext: false,
                                labelText: '次の予定の目的地', 
                                height: screen.designH(45), 
                                width: screen.designW(200),
                                controller:_next_destinationController, 
                              ),
                              SizedBox(height:screen.designH(16)),
                              TextDisplay(
                                labelText: '次の予定の到着時間', 
                                height: screen.designH(45), 
                                width: screen.designW(200),
                                exampletext: '１３時'
                                ),
                            ]  
                          ),
                          ),
                        SizedBox(height: screen.designH(112),),
                        ChoiceButtonRed(
                          height: screen.designH(45),
                          width: screen.designW(250), 
                          text: '検索', 
                          onPressed: () {  
                            print(_next_destinationController.text);
                          },
                        )
                      ],  
                    ),
                    ),           
                    
                  ],
                ),
                
              ),
            
          ],
        ),
      ),
    );
  }
}
