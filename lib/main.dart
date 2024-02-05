import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_alchemy_app/View/Sign_Up_Page.dart';
import 'package:time_alchemy_app/View/login_page.dart';
import 'package:time_alchemy_app/View/search_page.dart';

import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';
import 'package:time_alchemy_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // if (Platform.isIOS) {
  //   // ios
  //   // ここでFirebaseの初期化を行う前に、既存のFirebase Appが存在しないことを確認する
  //   if (Firebase.apps.isEmpty) {
  //     await Firebase.initializeApp();
  //   }
  // } else if (Platform.isAndroid) {
  // android
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // }

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false, //debugをけすやつ
        title: 'Flutter app',
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // スプラッシュ画面などに書き換えても良い
              return const SizedBox();
            }
            if (snapshot.hasData) {
              // User が null でなない、つまりサインイン済みのホーム画面へ
              return SearchPage();
            }
            // User が null である、つまり未サインインのサインイン画面へ
            return StartPage();
          },
        ),
      );
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _StartPage(),
    );
  }
}

class _StartPage extends StatelessWidget {
  _StartPage({super.key});
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Sign_Up_Page()),
                    );
                  },
                ),
              ),
              // ChoiceButton(text: 'text', onPressed: () {})
            ],
          ),
        ));
  }
}
