import 'package:flutter/material.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';

// 背景茶色の時のappber
class AppBarWhiteTextCompornent extends StatelessWidget
    implements PreferredSizeWidget {
  final String title; //Appbarテキスト
  final String rightText;
  final GestureTapCallback onPressedLeft; //画面遷移したい画面のタグ
  final GestureTapCallback onPressedRight;
  final bool showLeftIcon; // テキストとアイコンを表示するかどうかのフラグ
  final bool showRightText;

  @override
  final Size preferredSize;

  AppBarWhiteTextCompornent({
    required this.title,
    required this.rightText,
    required this.onPressedLeft,
    required this.onPressedRight,
    this.showLeftIcon = true, // デフォルトは表示
    this.showRightText = true,
  }) : preferredSize = Size.fromHeight(kToolbarHeight + 5); // AppBarの高さを指定

  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0, // 背景透明
      backgroundColor: Colors.transparent,
      leading: showLeftIcon
          ? IconButton(
              // 戻るアイコン
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors_compornet.globalBackgroundColorwhite,
              onPressed: onPressedLeft,
            )
          : null, // アイコン非表示
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.split('\n')[0], // 改行コードで分割し、最初の行を表示
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
          if (title.split('\n').length > 1)
            Text(
              title.split('\n')[1], // 2行目があれば表示
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.white,
              ),
            ),
        ],
      ),
      actions: showRightText
          ? [
              TextButton(
                onPressed: onPressedRight,
                child: Text(
                  rightText,
                  style: const TextStyle(
                    color: Colors_compornet.globalBackgroundColorwhite,
                    fontSize: 15,
                  ),
                ),
              ),
            ]
          : null,
    );
  }
}

// 背景白色の時のappber(左backIcon)
class AppBarBrackIconCompornent extends StatelessWidget
    implements PreferredSizeWidget {
  final String title; //Appbarテキスト
  final String rightText; // 右テキスト
  final GestureTapCallback onPressedLeft; //画面遷移したい画面のタグ
  final GestureTapCallback onPressedRight;
  final bool showLeftIcon; // テキストとアイコンを表示するかどうかのフラグ
  final bool showRightText;

  @override
  final Size preferredSize;

  AppBarBrackIconCompornent({
    required this.title,
    required this.rightText,
    required this.onPressedLeft,
    required this.onPressedRight,
    this.showLeftIcon = true, // デフォルトは表示
    this.showRightText = true,
  }) : preferredSize = Size.fromHeight(kToolbarHeight + 5); // AppBarの高さを指定

  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0, // 背景透明
      backgroundColor: Colors.transparent,
      leading: showLeftIcon
          ? IconButton(
              // 戻るアイコン
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors_compornet.globalBackgroundColorRed,
              onPressed: onPressedLeft,
            )
          : null, // アイコン非表示
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.split('\n')[0], // 改行コードで分割し、最初の行を表示
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors_compornet.textfontColorBlack,
            ),
          ),
          if (title.split('\n').length > 1)
            Text(
              title.split('\n')[1], // 2行目があれば表示
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors_compornet.textfontColorBlack,
              ),
            ),
        ],
      ),
      actions: showRightText
          ? [
              TextButton(
                onPressed: onPressedRight,
                child: Text(
                  rightText,
                  style: const TextStyle(
                    color: Colors_compornet.textfontColorBlack,
                    fontSize: 15,
                  ),
                ),
              ),
            ]
          : null,
      shape: const Border(
          bottom: BorderSide(
              color: Colors_compornet.borderColorGray, width: 1)), // 下にボーダー線
    );
  }
}

// 背景白色の時のappber(左TextButton)
class AppBarBrackTextButtonCompornent extends StatelessWidget
    implements PreferredSizeWidget {
  final String leftText;
  final String title; //Appbarテキスト
  final String rightText; // 右テキスト
  final GestureTapCallback onPressedLeft; //画面遷移したい画面のタグ
  final GestureTapCallback onPressedRight;
  final bool showLeftIcon; // テキストとアイコンを表示するかどうかのフラグ
  final bool showRightText;

  @override
  final Size preferredSize;

  AppBarBrackTextButtonCompornent({
    required this.leftText,
    required this.title,
    required this.rightText,
    required this.onPressedLeft,
    required this.onPressedRight,
    this.showLeftIcon = true, // デフォルトは表示
    this.showRightText = true,
  }) : preferredSize = Size.fromHeight(kToolbarHeight + 5); // AppBarの高さを指定

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const Border(
          // border線
          bottom: BorderSide(
        color: Colors_compornet.borderColorGray,
        width: 1,
      )),
      elevation: 0, // 背景透明
      backgroundColor: Colors.transparent,
      leadingWidth: 90,
      leading: showLeftIcon
          ? TextButton(
              onPressed: onPressedLeft,
              child: Text(
                leftText,
                style: const TextStyle(
                  color: Colors_compornet.textfontColorBlack,
                  fontSize: 15,
                ),
              ),
            )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.split('\n')[0], // 改行コードで分割し、最初の行を表示
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors_compornet.textfontColorBlack,
            ),
          ),
          if (title.split('\n').length > 1)
            Text(
              title.split('\n')[1], // 2行目があれば表示
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors_compornet.textfontColorBlack,
              ),
            ),
        ],
      ),
      actions: showRightText
          ? [
              TextButton(
                onPressed: onPressedRight,
                child: Text(
                  rightText,
                  style: const TextStyle(
                    color: Colors_compornet.globalBackgroundColorRed,
                    fontSize: 15,
                  ),
                ),
              ),
            ]
          : null,
    );
  }
}
