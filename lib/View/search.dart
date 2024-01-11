import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
            Padding(
              padding: EdgeInsets.only(top: screen.designH(100)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            labelText: '次の予定の目的地', 
                            height: screen.designH(45), 
                            width: screen.designW(200),
                            onTextChanged: (text){
                              setState(() {
                                next_destination =text.trim();
                              });
                            }, controller:_next_destinationController, 
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
                      onPressed: () {  },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
