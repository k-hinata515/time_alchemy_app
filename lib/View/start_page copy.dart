import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/screen_pod.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(), // MyAppを直接指定
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Scaffold(
        appBar: AppBarBrackTextButtonCompornent(
            leftText: 'キャンセル',
            title: 'プロフィールを編集',
            rightText: '完了',
            onPressedLeft: () => {},
            onPressedRight: () => {}),
        body: Stack(
          children: [
            //BackgroundWidget(),
            // AppBarTextWhiteCompornent(
            //   title: '趣味を選んでください',
            //   rightText: '編集',
            //   onPressedLeft: () => {},
            //   onPressedRight: () => {},
            //   //showRightText: false, //表示したくない場合これ書く
            // ),
            // AppBarBrackTextButtonCompornent(
            //   leftText: 'キャンセル',
            //   title: 'パスワードを変更',
            //   rightText: '完了',
            //   onPressedLeft: () => {},
            //   onPressedRight: () => {},
            // ),
            Container()
          ],
        ));
  }
}
