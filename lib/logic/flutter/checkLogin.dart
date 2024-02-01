import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/View/search.dart';
import 'package:time_alchemy_app/main.dart';

Future<void> checkLoginStatusAndNavigate(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  // 現在のユーザーを取得
  User? user = auth.currentUser;

  if (user != null) {
    // ログインしている場合は、通常の画面遷移を継続
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  } else {
    // ログインしていない場合は、ログイン画面に遷移
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StartPage()),
    );
  }
}
