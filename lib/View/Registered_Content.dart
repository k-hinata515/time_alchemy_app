import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';


void main () => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => Registered_Content(), // Wrap your app
  ),
);


class Registered_Content extends StatelessWidget{
  Registered_Content({Key? key}) : super (key:key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Registered_Content_Page(),
    );
  }

}
class Registered_Content_Page extends StatefulWidget{
  

   State<StatefulWidget> createState() => _Registered_Content_Page();

}
class _Registered_Content_Page extends State<Registered_Content_Page>{
  //テストデータ
  final String name = 'ECC太郎';
  final String tel = '0120-442-1811';
  final String password = '22201111';
  final List<String> tag = [
    //
    'ビール',
    'ワイン',
    '日本酒',
    '焼酎',
    'ウィスキー',
    'ジン',
    'ウォッカ',
    '紹興酒',
    'マッコリ',
    'カクテル',
    'ビール',
    'ワイン',
    '日本酒',
    '焼酎',
    'ウィスキー',
    'ジン',
    'ウォッカ',
    '紹興酒',
    'マッコリ',
    'カクテル',
    'ビール',
    'ワイン',
    '日本酒',
    '焼酎',
    'ウィスキー',
    'ジン',
    'ウォッカ',
    '紹興酒',
    'マッコリ',
    'カクテル',
  ];
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);  //screenpodの処理
    return Scaffold(
      resizeToAvoidBottomInset: false,  //キーボード表示時のオーバーフローを無くす
      backgroundColor:  Colors_compornet.globalBackgroundColorRed,
      appBar: AppBarWhiteTextCompornent(
        title: '登録内容の確認',
        rightText: '次へ',
        onPressedLeft: () => {},
        onPressedRight: () => {},
        showRightText: false, //次へのアイコンを削除
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
                  String_Display(
                  labelText: 'ユーザネーム', 
                   displayText: name , 
                  ),
                  SizedBox(height: screen.designH(16),),
                  String_Display(
                  labelText: '電話番号またはメールアドレス', 
                   displayText:tel , 
                  ),
                  SizedBox(height: screen.designH(16),),
                  String_Display(
                  labelText: 'パスワード', 
                   displayText:password, 
                  ),
                  SizedBox(height: screen.designH(16),),
                  List_Display(
                  labelText: '趣味', 
                  stringList: tag, 
                  height: 200, 
                  width: 300
                  ),
                  SizedBox(height: screen.designH(48),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      ChoiceButtonWhite(
                      text: '変更', 
                      onPressed: ()=>{

                      }, 
                      height: 150, 
                      width: 30
                      ),
                      SizedBox(width: screen.designW(16),),
                      ChoiceButtonRed(
                        text: '次へ', 
                        onPressed: ()=>{}, 
                        height: 150, 
                        width: 30,
                      ),
                    ],
                  ),
                  
                  

              ],
            ),
            ),
          ),
        ],
      ),

    );
  }

}