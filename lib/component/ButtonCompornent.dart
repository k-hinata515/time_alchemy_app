import 'package:flutter/material.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';
class ChoiceButtonRed extends StatelessWidget{
  final String text;    //ボタンのテキスト
  final GestureTapCallback onPressed; //画面遷移したい画面のタグ
  final double height;
  final double width;
  ChoiceButtonRed({required this.text,required this.onPressed ,required this.height ,required this.width,  });

    @override
      Widget build(BuildContext context){
        final screen = ScreenRef(context).watch(screenProvider);
        return ElevatedButton(
          onPressed:onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: Color.fromRGBO(252, 251, 255, 1,),
              fontSize: 20,
            ),
            ),
          style: ElevatedButton.styleFrom(
            elevation:20,
            fixedSize: Size(screen.designW(width),screen.designH(height)), 
            backgroundColor: Color.fromRGBO(126, 70, 62, 1),
            shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(40),
            ),
          ),
        );
      } 
}

class ChoiceButtonWhite extends StatelessWidget{
    final String text;    //ボタンのテキスト
  final GestureTapCallback onPressed; //画面遷移したい画面のタグ
  final double height;
  final double width;
  ChoiceButtonWhite({required this.text,required this.onPressed ,required this.height ,required this.width , });

    @override
      Widget build(BuildContext context){
        final screen = ScreenRef(context).watch(screenProvider);
        return ElevatedButton(
          onPressed:onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: Color.fromRGBO(51, 51, 51, 1),
              fontSize: 20,
            ),
            ),
          style: ElevatedButton.styleFrom(
            elevation:20,
            fixedSize: Size(screen.designH(height),screen.designW(width)), 
            backgroundColor: Color.fromRGBO(252, 251, 255, 1,),
            shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(15),
            ),
          ),
        );
      } 
}

