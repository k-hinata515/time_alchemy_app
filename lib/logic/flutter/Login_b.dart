import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_alchemy_app/logic/flutter/saveLogin.dart';

class LoginBackend {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ユーザーIDを取得
      String? userID = userCredential.user!.uid;
//getpref
//true
//logim
// false
// pref saveUserID(userID);
      // ログイン情報を保存
      saveLoginInfo(true);
      saveUserID(userID);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('ログインエラー: $e');
      throw e;
    }
  }
}
