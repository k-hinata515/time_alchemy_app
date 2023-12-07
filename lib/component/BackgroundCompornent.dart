import 'package:flutter/material.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/screen_pod.dart';

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Container(
      // 背景の茶色の色を指定
      color: Colors_compornet.globalBackgroundColorRed,
      child: Stack(
        children: [
          Positioned(
            top: screen.designH(-150), // 画像の位置を調整
            left: screen.designW(25),
            child: Image.asset(
              'assets/logo_images/BackgroundTimeImage.png',
              width: screen.designH(570), // 画像のサイズを調整
              height: screen.designW(513),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: screen.designH(0), // 画像の位置を調整
            left: screen.designW(0),
            child: Image.asset(
              'assets/logo_images/Background.png',
              width: screen.designH(393), // 画像のサイズを調整
              height: screen.designW(716),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
