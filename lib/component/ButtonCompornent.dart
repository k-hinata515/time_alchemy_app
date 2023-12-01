import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget{
  final String text;    //ボタンのテキスト
  final GestureTapCallback onPressed; //画面遷移したい画面のタグ
  const ChoiceButton({required this.text,required this.onPressed});

    Widget build(BuildContext context){
      double screenWidth = MediaQuery.of(context).size.width;  //画面サイズ（横幅） 
      double screenHeight = MediaQuery.of(context).size.height; //画面サイズ（縦幅)
    return OutlinedButton(
      child: Text(text),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        fixedSize: Size(
          screenWidth*1.33,
          screenHeight*0.45,
          ),
      )
      );
    } 
}