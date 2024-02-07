import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/View/Sign_Up_Page.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';
import 'package:time_alchemy_app/logic/flutter/Registered_Content_b.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Registered_Content(), // Wrap your app
      ),
    );

class Registered_Content extends StatelessWidget {
  Registered_Content({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //デバックけすやつ
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Registered_Content_Page(
        username: '', // 仮のユーザー名
        emailOrPhoneNumber: '', // 仮のメールアドレスまたは電話番号
        password: '', // 仮のパスワード
        selectedTags: [],
      ),
    );
  }
}

class Registered_Content_Page extends StatefulWidget {
  final String username;
  final String emailOrPhoneNumber;
  final String password;
  final List<String> selectedTags;

  const Registered_Content_Page(
      {Key? key,
      required this.username,
      required this.emailOrPhoneNumber,
      required this.password,
      required this.selectedTags})
      : super(key: key);

  State<StatefulWidget> createState() => _Registered_Content_Page();
}

class _Registered_Content_Page extends State<Registered_Content_Page> {
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider); //screenpodの処理
    return Scaffold(
      resizeToAvoidBottomInset: false, //キーボード表示時のオーバーフローを無くす
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      appBar: AppBarWhiteTextCompornent(
        title: '登録内容の確認',
        rightText: '次へ',
        onPressedLeft: () => {
          // "戻る" ボタンが押されたときの処理
          Navigator.pop(context)
        },
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
                    displayText: widget.username,
                    height: 45,
                    width: 300,
                  ),
                  SizedBox(
                    height: screen.designH(16),
                  ),
                  String_Display(
                    labelText: '電話番号またはメールアドレス',
                    displayText: widget.emailOrPhoneNumber,
                    height: 45,
                    width: 300,
                  ),
                  SizedBox(
                    height: screen.designH(16),
                  ),
                  String_Display(
                    labelText: 'パスワード',
                    displayText: widget.password,
                    height: 45,
                    width: 300,
                  ),
                  SizedBox(
                    height: screen.designH(16),
                  ),
                  List_Display(
                      labelText: '趣味',
                      stringList: widget.selectedTags,
                      height: 200,
                      width: 300),
                  SizedBox(
                    height: screen.designH(48),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceButtonWhite(
                          text: '変更',
                          onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Sign_Up_Page()),
                                )
                              },
                          height: 30,
                          width: 150),
                      SizedBox(
                        width: screen.designW(16),
                      ),
                      ChoiceButtonRed(
                        text: '次へ',
                        onPressed: () => _newregistration(context),
                        width: 150,
                        height: 45,
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

  void _newregistration(BuildContext context) {
    newregistration(
      username: widget.username,
      emailOrPhoneNumber: widget.emailOrPhoneNumber,
      password: widget.password,
      selectedTags: widget.selectedTags,
      context: context, // 追加: context引数を提供
    );
  }
}
