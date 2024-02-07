import 'package:flutter/material.dart';
import 'package:time_alchemy_app/View/add_destination_page.dart';
import 'package:time_alchemy_app/View/profile_page.dart';
import 'package:time_alchemy_app/View/search_map_page.dart';
import 'package:time_alchemy_app/View/search_page.dart';
import 'package:time_alchemy_app/View/setting_page.dart';

//ホーム画面
class SearchPageTransition {
  static void navigate(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(),
      ),
    );
  }
}

//プロフィール画面
class ProfileEditPageTransition {
  static void navigate(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileEditPage(),
      ),
    );
  }
}

//マップ画面
class MapScreenTransition {
  static void navigate(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SearchMap(),
      ),
    );
  }
}

//サーチ画面
class Add_destination_PageTransition {
  static void navigate(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Add_destination_Page(),
      ),
    );
  }
}

//設定画面
class SettingPageTransition {
  static void navigate(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SettingPage(),
      ),
    );
  }
}
