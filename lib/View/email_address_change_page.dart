import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/menubar.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/screen_pod.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => email_address_change_page(), // MyAppを直接指定
      ),
    );

class email_address_change_page extends StatelessWidget {
   email_address_change_page({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      home: EmailAddressChangePage(),
    );
  }
}

class EmailAddressChangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String nextPassword = '';
    String currentPassword = '';
    final TextEditingController _currentpasswordcontroller = TextEditingController();
    final TextEditingController _nextpasswordcontroller = TextEditingController(); 
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
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screen.height * 0.15,
                ),
                MyTextFormField(
                  labelText: '現在のメールアドレス',
                  height: 40,
                  width:300,
                  controller: _currentpasswordcontroller,
                  obscuretext: false,
                ),

                SizedBox(
                  height: screen.height * 0.02,
                ),
                MyTextFormField(
                  labelText: '変更したいメールアドレス',
                  height: 40,
                  width: 300,
                  controller: _nextpasswordcontroller,
                  obscuretext: false, //パスワードを
                ),
                SizedBox(
                  height: screen.height * 0.15,
                ),
                // 送信ボタン
                ChoiceButtonRed(
                  text: '変更',
                  onPressed: () {
                    //TODO: メールアドレス変更処理を実行する
                    currentPassword = _currentpasswordcontroller.text;
                    nextPassword =_nextpasswordcontroller.text;
                    //テスト
                    print(currentPassword);
                    print(nextPassword);
                  },
                  height: 45,
                  width: 120,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClockMenu(),
          )
        ],
      )
    );
  }
  
  void setState(Null Function() param0) {}
}
