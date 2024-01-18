import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

class X_IconButton extends StatelessWidget {
  final String label;
  final String imageAsset;
  final GestureTapCallback onPressed;
  X_IconButton(
      {required this.label,
      required this.imageAsset,
      required this.onPressed}); //表示する　テキスト、画像、画面遷移先を引数として使う
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);

    return Container(
      height: screen.designH(40),
      width: screen.designW(300),
      child: Material(
        elevation: 10, // 影の強さを調整できます
        borderRadius: BorderRadius.circular(40),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Colors_compornet.globalBackgroundColorRed,
              width: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: screen.designW(40)),
              Image.asset(
                imageAsset,
                height: screen.designH(48),
                width: screen.designW(48),
              ),
              SizedBox(width: screen.designW(8)),
              Text(
                label,
                style: TextStyle(
                  color: Colors_compornet.textfontColorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Instagram_IconButton extends StatelessWidget {
  final String label;
  final String imageAsset;
  final GestureTapCallback onPressed;
  Instagram_IconButton(
      {required this.label,
      required this.imageAsset,
      required this.onPressed}); //表示する　テキスト、画像、画面遷移先を引数として使う
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);

    return Container(
      height: screen.designH(40),
      width: screen.designW(300),
      child: Material(
        elevation: 10, // 影の強さを調整できます
        borderRadius: BorderRadius.circular(40),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Colors_compornet.globalBackgroundColorRed,
              width: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: screen.designW(40)),
              Image.asset(
                imageAsset,
                height: screen.designH(48),
                width: screen.designW(48),
              ),
              SizedBox(width: screen.designW(8)),
              Text(
                label,
                style: TextStyle(
                  color: Colors_compornet.textfontColorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final double width;
  final double height;
  MapIconButton(
      {required this.onPressed, required this.width, required this.height});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      onPressed: onPressed,
      child: Icon(
        Icons.location_on,
      ),
      padding: EdgeInsets.all(16),
      color: Colors_compornet.globalBackgroundColorRed,
      textColor: Colors_compornet.globalBackgroundColorwhite,
      shape: CircleBorder(),
    );
  }
}
