
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/menubar.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/screen_pod.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
// import 'package:time_alchemy_app/screen_pod.dart';


// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => MyApp(), // MyAppを直接指定
//       ),
//     );

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      home: aPasswordChangePage(),
    );
  }


class aPasswordChangePage extends StatefulWidget {
  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<aPasswordChangePage> {
  String _oldPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';
  final TextEditingController oldpassword = TextEditingController();
  final TextEditingController newpassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors_compornet.globalBackgroundColorwhite,
      appBar: AppBarBrackTextButtonCompornent(
        leftText: 'キャンセル',
        title: 'パスワード変更',
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
                // 旧パスワード入力フィールド
                PasswordFormField(
                  TextLabel: '現在のパスワード',
                  controller: oldpassword,
                  obscureText: false,
                  
                ),
                SizedBox(
                  height: screen.height * 0.02,
                ),
                // 新しいパスワード入力フィールド
                PasswordFormField(
                  TextLabel: '新しいパスワード',
                  controller: newpassword,
                  obscureText: false,
                  
                ),
                SizedBox(
                  height: screen.height * 0.02,
                ),

                // 確認用パスワード入力フィールド
                PasswordFormField(
                  TextLabel: '確認パスワード',
                  controller: confirmPassword,
                  obscureText: false,

                ),
                SizedBox(
                  height: screen.height * 0.05,
                ),
                // 送信ボタン
                ChoiceButtonRed(
                  text: '変更',
                  onPressed: () {
                    _oldPassword = oldpassword.text;
                    _newPassword = newpassword.text;
                    _confirmPassword = confirmPassword.text;
                    changePassword();
                  },
                  height: 0.01,
                  width: 0.05,
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

  // パスワード変更処理
  Future<void> changePassword() async {
    // 成功
    if (_oldPassword != _newPassword && _newPassword == _confirmPassword) {
      //TODO:  一致している場合、パスワードを変更する
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('パスワード変更成功'),
            content: Text('パスワードを変更しました。'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  // 画面を閉じる
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('パスワードが一致しません'),
            content: Text('旧パスワードと新しいパスワードもしくは確認用パスワードが一致しません。'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  // 画面を閉じる
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class PasswordFormField extends StatelessWidget {
  final String TextLabel;
  final TextEditingController controller;
  final bool obscureText;
  PasswordFormField({
    required this.TextLabel,
    required this.controller, 
    required this.obscureText,

  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Container(
      height: screen.height * 0.05,
      width: screen.width * 0.8,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: TextLabel, //textfield内のラベル
          hintStyle:
              TextStyle(fontSize: 12, color: Color.fromRGBO(126, 70, 62, 1)),
          fillColor: Color.fromRGBO(
            252,
            251,
            255,
            1,
          ), //textfeild内の色変更
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Color.fromRGBO(126, 70, 62, 1),
              width: 4.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Color.fromRGBO(126, 70, 62, 1),
              width: 2.0, //枠線の太さ変更
            ),
          ),
        ),
        
      ),
    );
  }
}
