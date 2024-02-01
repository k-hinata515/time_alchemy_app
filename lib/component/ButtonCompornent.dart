import 'package:flutter/material.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

class ChoiceButtonRed extends StatelessWidget {
  final String text; //ボタンのテキスト
  final GestureTapCallback onPressed; //画面遷移したい画面のタグ
  final double width;
  final double height;

  ChoiceButtonRed({
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
  });

    @override
      Widget build(BuildContext context){
        final screen = ScreenRef(context).watch(screenProvider);
        return SizedBox(
          height: screen.designH(height),
          width: screen.designW(width),
          child: ElevatedButton(
          onPressed:onPressed,
          child: Text(
            text,
            style: TextStyle(
              color:Colors_compornet.textfontColorWhite,
              fontSize: screen.designW(15),
              
            ),
            ),
          style: ElevatedButton.styleFrom(
            elevation:20,
            backgroundColor: Colors_compornet.globalBackgroundColorRed,
            shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(40),
            ),
          ),
          
        ),
      );
  }
}

class ChoiceButtonWhite extends StatelessWidget {
  final String text; //ボタンのテキスト
  final GestureTapCallback onPressed; //画面遷移したい画面のタグ
  final double height;
  final double width;
  ChoiceButtonWhite({
    required this.text,
    required this.onPressed,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return SizedBox(
          height: screen.designH(height),
          width: screen.designW(width),
          child: ElevatedButton(
          onPressed:onPressed,
          child: Text(
            text,
            style: TextStyle(
              color:Colors_compornet.textfontColorBlack,
              fontSize: screen.designW(15),
            ),
            ),
          style: ElevatedButton.styleFrom(
            elevation:20,
            backgroundColor: Colors_compornet.textfontColorWhite,
            shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(40),
            ),
          ),
        )
        );
  }
}
