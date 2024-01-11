import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final double height;
  final double width;
  final TextEditingController controller ;
  final Function(String) onTextChanged;
  MyTextFormField({required this.labelText, required this.height,required this.width, required this.onTextChanged, required this.controller, });

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 12,
            color: Colors_compornet.textfontcolorocher,
            ),
        ),
        SizedBox(height: screen.designH(2),),
        Container(      
          height: screen.designH(height), // 高さの変更
          width:screen.designW(width), // 横幅の変更
          child: TextFormField(
            controller: controller,
            onChanged: (text){
              onTextChanged(text);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors_compornet.globalBackgroundColorwhite,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors_compornet.globalBackgroundColorRed,
                  width: 2.0  //太さ
                ),
                borderRadius: BorderRadius.circular(40) //外側の丸み
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(
                  color:  Colors_compornet.globalBackgroundColorRed, width: 2,
                  
                ),
                borderRadius: BorderRadius.circular(40) 
              )
            ),
          ),
        ),
      ],
      // ),
    );
  }
}




class List_Display extends StatelessWidget {
  final String labelText;
  final List<String> stringList; // 文字列データのリストを保持するように変更
  final double height;
  final double width;

  List_Display({
    required this.labelText,
    required this.stringList,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 12,
            color: Colors_compornet.textfontcolorocher,
          ),
        ),
        SizedBox(height: screen.designH(2)),
        Container(
          height: screen.designH(height),
          width: screen.designW(width),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors_compornet.globalBackgroundColorRed,
              width: 2.0,
            ),
            color: Colors_compornet.globalBackgroundColorwhite,
          ),
          padding: EdgeInsets.all(10), // 必要に応じてパディングを追加
          child: Center(
            child: ListView.builder(
            itemCount: (stringList.length / 3).ceil(), // 3つずつの列数
            itemBuilder: (BuildContext context, int rowIndex) {
              return Row(
                children: List.generate(3, (int index) {
                  final itemIndex = rowIndex * 3 + index;
                  if (itemIndex < stringList.length) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10), // アイテム間のスペーシング
                      child: Text(
                        '・${stringList[itemIndex]}', // 中黒を付ける
                        style: TextStyle(
                          color: Colors_compornet.textfontColorBlack,
                        ),
                      ),
                    );
                  } else {
                    return Container(); // 空のコンテナを追加
                  }
                }),
              );
            },
          ),
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class String_Display extends StatelessWidget {
  final String labelText;
  final String displayText;

  String_Display({
    required this.labelText,
    required this.displayText, 
  });

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 12,
            color: Colors_compornet.textfontcolorocher,
          ),
        ),
        SizedBox(height: screen.designH(2)),
        Container(
          height: screen.designH(45),
          width: screen.designW(300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors_compornet.globalBackgroundColorRed,
              width: 2.0,
            ),
            color: Colors_compornet.globalBackgroundColorwhite,
          ),
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              displayText,
              style: TextStyle(
                color: Colors_compornet.textfontColorBlack,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class TextFormButton extends StatelessWidget {
  final String labelText;
  final double height;
  final double width;
  final String exampletext;

  TextFormButton({
    required this.labelText,
    required this.height,
    required this.width,
    required this.exampletext,
  });

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Container(
      margin: EdgeInsets.only(right: screen.designW(10)), // 余白を追加（必要に応じて調整）
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: 12,
              color: Colors_compornet.textfontcolorocher,
            ),
          ),
          SizedBox(height: screen.designH(2)),
          Container(
            height: screen.designH(height),
            width: screen.designW(width),
            child: ElevatedButton(
              onPressed: () {
                // ボタンが押された時の処理
              },
              style: ElevatedButton.styleFrom(
                primary: Colors_compornet.globalBackgroundColorwhite,
                onPrimary: Colors_compornet.globalBackgroundColorRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                side: BorderSide(
                  color: Colors_compornet.globalBackgroundColorRed,
                  width: 2.0,
                ),
              ),
              child: Text(exampletext),
            ),
          ),
        ],
      ),
    );
  }
}

class TextDisplay extends StatelessWidget {
  final String labelText;
  final double height;
  final double width;
  final String exampletext;

  TextDisplay({
    required this.labelText,
    required this.height,
    required this.width,
    required this.exampletext,
  });

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Container(
      margin: EdgeInsets.only(right: screen.designW(10)), // 余白を追加（必要に応じて調整）
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: 12,
              color: Colors_compornet.textfontcolorocher,
            ),
          ),
          SizedBox(height: screen.designH(2)),
          Container(
            height: screen.designH(height),
            width: screen.designW(width),
            decoration: BoxDecoration(
              color: Colors_compornet.globalBackgroundColorwhite,
              border: Border.all(
                color: Colors_compornet.globalBackgroundColorRed,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                exampletext,
                style: TextStyle(
                  color: Colors_compornet.globalBackgroundColorRed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
