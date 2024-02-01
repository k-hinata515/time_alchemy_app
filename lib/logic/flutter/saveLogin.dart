import 'package:shared_preferences/shared_preferences.dart';

// ログイン情報を保存するメソッド
Future<void> saveLoginInfo(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

// ユーザーIDを保存するメソッド
Future<void> saveUserID(String userID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userID', userID);
}

// ユーザーIDを取得する
Future<String?> getUserID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userID');
}
