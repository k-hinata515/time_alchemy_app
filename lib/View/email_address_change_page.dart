import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';

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
      home: EmailAddressChangePage(),
    );
  }
}

class EmailAddressChangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors_compornet.globalBackgroundColorwhite,
      appBar: AppBarBrackTextButtonCompornent(
        leftText: 'キャンセル',
        title: 'メールアドレス変更',
        rightText: '完了',
        onPressedLeft: () => {},
        onPressedRight: () => {},
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screen.height * 0.15,
            ),
            MyTextFormField(
              labelText: '現在のメールアドレス',
              height: 40,
              width: 300,
            ),

            SizedBox(
              height: screen.height * 0.02,
            ),

            MyTextFormField(
              labelText: '変更したいメールアドレス',
              height: 40,
              width: 300,
            ),
            SizedBox(
              height: screen.height * 0.15,
            ),
            // 送信ボタン
            ChoiceButtonRed(
              text: '変更',
              onPressed: () {
                //TODO: メールアドレス変更処理を実行する
              },
              height: 0.01,
              width: 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
