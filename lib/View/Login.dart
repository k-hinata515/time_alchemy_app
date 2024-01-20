import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/View/Sign_Up_Page.dart';
import 'package:time_alchemy_app/View/search.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/IconButton.dart';
import 'package:time_alchemy_app/logic/flutter/Login_b.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/main.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Login(), // Wrap your app
      ),
    );

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final LoginBackend _loginBackend = LoginBackend();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    final screen = ScreenRef(context).watch(screenProvider); //screenpodの処理

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      appBar: AppBarWhiteTextCompornent(
        title: 'ログイン',
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
            padding: EdgeInsets.only(
                top: screen.designH(100)), //backgroundwidgetにあわせるに必要な余白
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, //垂直方こうに中央寄せ
                children: [
                  MyTextFormField(
                    obscuretext: false,
                    height: 40,
                    width: 300,
                    labelText: 'ユーザーID、メールアドレス、電話番号 ',
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: screen.designH(32),
                  ),
                  MyTextFormField(
                    obscuretext: true,
                    labelText: 'パスワード',
                    height: 40,
                    width: 300,
                    controller: _passwordController,
                  ),
                  SizedBox(height: screen.designH(24)),
                  ChoiceButtonRed(
                      text: 'ログイン',
                      onPressed: () async {
                        email = _emailController.text;
                        password = _passwordController.text;
                        print(email);
                        print(password);
                        if (email.isNotEmpty && password.isNotEmpty) {
                          try {
                            User? user = await _loginBackend
                                .signInWithEmailAndPassword(email, password);

                            if (user != null) {
                              //ログイン成功時にsearch.dartに画面遷移
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Search()),
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            // FirebaseAuthExceptionからエラーコードを取得し、エラーメッセージを表示
                            String errorMessage = 'ログインに失敗しました。';

                            switch (e.code) {
                              case 'user-not-found':
                                errorMessage = 'ユーザーが見つかりませんでした。';
                                break;
                              case 'wrong-password':
                                errorMessage = 'パスワードが間違っています。';
                                break;
                              case 'invalid-email':
                                errorMessage = '無効なメールアドレスです。';
                                break;
                              // 他にも必要なエラーコードがあれば追加
                            }

                            // エラーメッセージの表示
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                              ),
                            );

                            print('FirebaseAuthException: $e');
                          }
                        } else {
                          // ユーザーが入力していない場合の処理を追加
                          // 例: エラーメッセージの表示
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('ユーザーIDとパスワードを入力してください。'),
                            ),
                          );
                        }
                      },
                      height: 150,
                      width: 45),
                  SizedBox(
                    height: screen.designH(16),
                  ),
                  Text(
                    'または',
                    style: TextStyle(
                      color: Colors_compornet.textfontColorGray,
                    ),
                  ),
                  SizedBox(
                    height: screen.designH(24),
                  ),
                  TextButton(
                    onPressed: () {
                      // Sign_Up_Page.dart に移動
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sign_Up_Page()),
                      );
                    },
                    child: Text(
                      '＞新規登録はこちら',
                      style: TextStyle(
                        color: Colors_compornet.globalBackgroundColorRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screen.designH(24),
                  ),
                  X_IconButton(
                      label: 'Xでログイン',
                      imageAsset: 'assets/logo_images/X_icon.png',
                      onPressed: () => {}),
                  SizedBox(
                    height: screen.designH(32),
                  ),
                  Instagram_IconButton(
                    label: 'Instagramでログイン',
                    imageAsset: 'assets/logo_images/Instagram_icon.png',
                    onPressed: () => {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // body:Column(
      //   children: [
      //     Center(
      //       child: MyTextFormField(
      //       height: 40,
      //       width: 300,
      //       labelText: 'ユーザーID、メールアドレス、電話番号 ',
      //       )
      //     )

      //   ],
      // ),
    );
  }
}
