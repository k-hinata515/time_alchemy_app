import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

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
      builder: DevicePreview.appBuilder,
      home: ProfileEditPage(),
    );
  }
}

class ProfileEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);

    return Scaffold(
      backgroundColor: Colors_compornet.globalBackgroundColorwhite,
      body: Stack(
        children: [
          AppBackground(),
          HobbyDisplay(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screen.designH(127)),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundImage: NetworkImage(
                            'https://i.pinimg.com/736x/10/c9/44/10c944230e32a665618cb6223902fda5.jpg'),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        'tanaso',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors_compornet.textfontColorWhite,
                        ),
                      ),
                      SizedBox(height: 2.0), // 追加の余白
                      Text(
                        'tana.2220029', // 追加のテキスト
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors_compornet.textfontColorWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppBarWhiteTextCompornent(
            title: 'プロフィール',
            rightText: '編集',
            onPressedLeft: () => {},
            onPressedRight: () => {},
          ),
        ],
      ),
    );
  }
}

//茶色背景
class AppBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final height = constraint.maxHeight;
      final width = constraint.maxWidth;

      return Stack(
        children: <Widget>[
          Positioned(
            top: -height * 0.4,
            left: -height * 0.05,
            child: Container(
              height: height + 70,
              width: width + 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors_compornet.globalBackgroundColorRed.withOpacity(1),
              ),
            ),
          ),
        ],
      );
    });
  }
}

//趣味表示
class HobbyDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textContents = ["ゲーム", "太鼓の達人", "パソコン"];

    // 各要素の前に「・」を追加
    final formattedContents = textContents.map((text) => '・ $text').toList();

    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          SizedBox(height: 380),
          Text(
            '趣味',
            style: TextStyle(
              fontSize: 16,
              color: Colors_compornet.globalBackgroundColorRed,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors_compornet.globalBackgroundColorRed,
                  width: 2.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < textContents.length; i++)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        formattedContents[i],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors_compornet.globalBackgroundColorRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
