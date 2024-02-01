import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/View/Hobby_Registration.dart';
import 'package:time_alchemy_app/View/Registered_Content.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/IconButton.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';
import 'package:time_alchemy_app/logic/flutter/Sign_Up_Page_b.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Sign_Up(), // Wrap your app
      ),
    );

class Sign_Up extends StatelessWidget {
  Sign_Up({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Sign_Up_Page(),
    );
  }
}

class Sign_Up_Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Sign_Up_Page();
}

class _Sign_Up_Page extends State<Sign_Up_Page> {
  final TextEditingController username_controller = TextEditingController();
  final TextEditingController mailaddress_controller = TextEditingController();
  final TextEditingController password_controller = TextEditingController();
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    
    final screen = ScreenRef(context).watch(screenProvider); //screenpodの処理
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      appBar: AppBarWhiteTextCompornent(
        title: '新規登録',
        rightText: '次へ',
        onPressedLeft: () => {
          // "戻る" ボタンが押されたときの処理
          Navigator.pop(context)
        },
        onPressedRight: () => {},
        showRightText: false, //次へのアイコ
      ),
      body: Stack(
        children: [
          BackgroundWidget(),
          Padding(
            padding: EdgeInsets.only(
                top: screen.designH(100)), //backgroundwidgetにあわせるに必要な余白
            child: Center(
              child: Column(
                children: [
                  MyTextFormField(
                    obscuretext: false,
                    height: 40,
                    width: 300,
                    labelText: 'ユーザー名 ',
                    controller: username_controller,
                  ),
                  SizedBox(
                    height: screen.designH(24),
                  ),
                  MyTextFormField(
                    obscuretext: false,
                    height: 40,
                    width: 300,
                    labelText: 'メールアドレスまたは電話番号',
                    controller: mailaddress_controller,
                  ),
                  SizedBox(
                    height: screen.designH(24),
                  ),
                  MyTextFormField(
                    obscuretext: true,
                    height: 40,
                    width: 300,
                    labelText: 'パスワード',
                    controller: password_controller,
                  ),
                  SizedBox(
                    height: screen.designH(24),
                  ),
                  ChoiceButtonRed(
                    text: '次へ',
                    onPressed: () => _validateAndNavigate(context),
                    height: 45,
                    width: 120,
                  ),
                  SizedBox(
                    height: screen.designH(24),
                  ),
                  Text(
                    'または',
                    style: TextStyle(
                      color: Colors_compornet.textfontColorGray,
                    ),
                  ),
                  SizedBox(
                    height: screen.designH(32),
                  ),
                  X_IconButton(
                      label: 'Xでログイン',
                      imageAsset: 'assets/logo_images/X_icon.png',
                      onPressed: () => {}),
                  SizedBox(
                    height: screen.designH(24),
                  ),
                  Instagram_IconButton(
                    label: 'Instagramでログイン',
                    imageAsset: 'assets/logo_images/Instagram_icon.png',
                    onPressed: () => {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _validateAndNavigate(BuildContext context) {
    // バックエンドの処理を呼び出し
    validateAndNavigate(
      context,
      username_controller.text,
      mailaddress_controller.text.trim(),
      password_controller.text,
    );
  }
}
