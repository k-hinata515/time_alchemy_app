import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
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
        backgroundColor: Colors_compornet.globalBackgroundColorwhite,
        body: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screen.designH(140)),
              const Text(
                'TimeAlchemyへようこそ！',
                style: TextStyle(
                  color: Colors_compornet.globalBackgroundColorRed,
                  fontSize: 30,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Image.asset('assets/logo_images/TimeAlchemy_logo.png'),
              // SizedBox(height: screen.designH(130)), // テキストとボタンの間に余白を追加
              Container(
                margin: const EdgeInsets.only(
                  top: 0,
                  bottom: 10,
                ),
                child: TextButton(
                  child: Text('ログイン'),
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      fontSize: 27,
                    ),
                    backgroundColor: Colors_compornet.globalBackgroundColorRed,
                    foregroundColor:
                        Colors_compornet.globalBackgroundColorwhite,
                    minimumSize: Size(
                      screen.designH(315),
                      screen.designW(62),
                    ),
                  ),
                  onPressed: () {
                    // ToDo: ログインボタンが押されたときの処理
                  },
                ),
              ),
              Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 27,
                    ),
                    foregroundColor: Colors_compornet.globalBackgroundColorRed,
                    side: const BorderSide(
                      color: Colors_compornet.globalBackgroundColorRed,
                      width: 1,
                    ),
                    minimumSize: Size(
                      screen.designH(315),
                      screen.designW(62),
                    ),
                  ),
                  child: const Text('新規登録'),
                  //ToDo
                  onPressed: () {},
                ),
              ),
              // ChoiceButton(text: 'text', onPressed: () {})
            ],
          ),
        ));
  }
}
