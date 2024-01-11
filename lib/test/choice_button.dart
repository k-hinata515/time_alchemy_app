import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';

void main() => runApp(First());

class First extends StatelessWidget{
  First({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           ChoiceButtonWhite(
            text: '次へ',
            height: 10,
            width: 10,
            onPressed : (){
              context.push('/second');
            }
            ),
          ],
        ),
      ),
    );
  }
}