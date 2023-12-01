import 'package:flutter/material.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/background.dart';

class Second extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child:ChoiceButton(
          text: "戻る", 
          onPressed: (){
          Navigator.of(context).pushNamed('time_alchemy_app/component/background.dart');
        },
          )
        ),

    );
  }
}