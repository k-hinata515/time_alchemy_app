import 'package:flutter/material.dart';
import 'package:time_alchemy_app/screen_pod.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final String inputText;
  final double height;
  final double width;

  MyTextFormField({
    required this.inputText,
    required this.hintText,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Container(
      height: screen.designH(height), // 高さの変更
      width: screen.designW(width), // 横幅の変更
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText, //textfield内のラベル
          hintStyle: const TextStyle(
              fontSize: 12, color: Color.fromRGBO(126, 70, 62, 1)),
          fillColor: Color.fromRGBO(
            252,
            251,
            255,
            1,
          ), //textfeild内の色変更
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color.fromRGBO(126, 70, 62, 1),
              width: 4.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Color.fromRGBO(126, 70, 62, 1),
              width: 2.0, //枠線の太さ変更
            ),
          ),
        ),
      ),
    );
  }
}

// MailChangeFormField
class MailChangeFormField extends StatelessWidget {
  final String hintText;
  final String inputText;
  final double height;
  final double width;
  final TextEditingController controller; // 新しく追加

  MailChangeFormField({
    required this.inputText,
    required this.hintText,
    required this.height,
    required this.width,
    String initialValue = '', // 新しく追加
  }) : controller = TextEditingController(text: initialValue); // 新しく追加

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Container(
      height: screen.designH(height),
      width: screen.designW(width),
      child: TextFormField(
        controller: controller, // 新しく追加
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 12, color: Color.fromRGBO(126, 70, 62, 1)),
          fillColor: Color.fromRGBO(
            252,
            251,
            255,
            1,
          ),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color.fromRGBO(126, 70, 62, 1),
              width: 4.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Color.fromRGBO(126, 70, 62, 1),
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
