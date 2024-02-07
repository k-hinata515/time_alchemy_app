import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:time_alchemy_app/View/personal_information_preference_page.dart';
import 'package:time_alchemy_app/View/profile_edit_page.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/menubar.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'dart:math' as math;
import 'package:time_alchemy_app/logic/flutter/saveLogin.dart';
import 'package:time_alchemy_app/main.dart';

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
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      home: SettingPage(),
    );
  }
}

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors_compornet.globalBackgroundColorwhite,
        appBar: AppBarBrackIconCompornent(
          title: '設定',
          rightText: '',
          onPressedLeft: () {
            // TODO: 遷移先の処理を追加
            // "戻る" ボタンが押されたときの処理
            Navigator.pop(context);
          },
          onPressedRight: () {
            // TODO: 遷移先の処理を追加
          },
        ),
        body: Stack(
          children: [
            Column(
              children: [
                // メールアドレス変更
                LinkButton(
                  title: 'メールアドレス変更',
                  onPressedPage: () => (Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonalInformaitionPreferencePage(),
                    ),
                  )), //TODO: 遷移先の処理を追加
                ),
                BorderLine(),
                // 個人情報の設定
                LinkButton(
                  title: '個人情報の設定',
                  onPressedPage: () => (Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile_Edit_Page(),
                    ),
                  )), //TODO: 遷移先の処理を追加
                ),
                BorderLine(),
                // 非表示
                LinkButton(
                  title: '非表示',
                  onPressedPage: () => (), //TODO: 遷移先の処理を追加
                ),
                BorderLine(),
                // ログアウト
                LogoutDialog(),
                BorderLine(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClockMenu(),
            )
          ],
        ));
  }
}

//リンクボタン
class LinkButton extends StatelessWidget {
  final String title;
  final GestureTapCallback onPressedPage; //画面遷移したい画面のタグ

  LinkButton({
    required this.title,
    required this.onPressedPage,
  });

  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return InkWell(
      onTap: onPressedPage,
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: screen.height * 0.06, left: screen.width * 0.045)),
          Text(
            title,
            style: TextStyle(
              color: Colors_compornet.textfontColorBlack,
              fontSize: 14,
            ),
          ),
          //アイコン右に配置
          Spacer(),
          Transform(
            // アイコン180度回転
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
          SizedBox(
            width: screen.width * 0.03,
          )
        ],
      ),
    );
  }
}

//ログアウト

class LogoutDialog extends StatefulWidget {
  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  bool isLoggedIn = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinkButton(
        title: 'ログアウト',
        onPressedPage: () {
          // ログアウトの確認ダイアログを表示する
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors_compornet.globalBackgroundColorwhite,
                title: Text('ログアウト'),
                content: Text('ログアウトしますか？'),
                actions: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors_compornet.globalBackgroundColorwhite,
                      borderRadius: BorderRadius.circular(30.0), // ボタンの角丸
                    ),
                    child: TextButton(
                      child: Text(
                        'キャンセル',
                        style: TextStyle(
                          color: Colors_compornet.sortTagColor,
                        ),
                      ),
                      onPressed: () {
                        // ダイアログを閉じる
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors_compornet.globalBackgroundColorRed,
                      borderRadius: BorderRadius.circular(30.0), // ボタンの角丸
                    ),
                    child: TextButton(
                      child: Text(
                        'ログアウト',
                        style: TextStyle(
                          color: Colors_compornet.textfontColorWhite,
                        ),
                      ),
                      onPressed: () {
                        // ログアウト処理を実行する
                        logout();

                        // ダイアログを閉じる
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void logout() async {
    // Firebaseログアウト処理
    await FirebaseAuth.instance.signOut();

    // ユーザーのセッション情報を削除する
    saveLoginInfo(false);
    saveUserID("");

    // ログイン状態を更新する
    setState(() {
      isLoggedIn = false;
    });

    // 初期画面に戻る
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                App()), // ここでInitialScreenを、実際の初期画面のウィジェットに置き換えてください
        (route) => false);
  }
}

// ボーダーライン
class BorderLine extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero, // 上下の余白をなくしたいのになくせない
      child: const Divider(
        color: Colors_compornet.borderColorGray,
        thickness: 1.0,
      ),
    );
  }
}
