import 'package:flutter/material.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
void main() {
  runApp( Background());
}
class Background extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: ChoiceButton(
        text:"次へ",
        onPressed: (){
          Navigator.of(context).pushNamed('time_alchemy_app/component/second.dart');
        },
        ),
      )
    );
  }
}

