import 'package:flutter/material.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

class Toggle_Button extends StatefulWidget {
  final String buttonText1;
  final String buttonText2;
  final double height;
  final double width;

  Toggle_Button({
    required this.buttonText1,
    required this.buttonText2,
    required this.height,
    required this.width,
  });

  @override
  _Toggle_ButtonState createState() => _Toggle_ButtonState();
}

class _Toggle_ButtonState extends State<Toggle_Button> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (index) {
        setState(() {
          // ボタンが押されたら isSelected を更新して再ビルド
          isSelected = isSelected.map((item) => false).toList();
          isSelected[index] = true;
        });
      },
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            width: widget.width,
            height: widget.height,
            child: Center(
              child: Text(
                widget.buttonText1,
                style: TextStyle(
                  fontWeight: isSelected[0] ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            width: widget.width,
            height: widget.height,
            child: Center(
              child: Text(
                widget.buttonText2,
                style: TextStyle(
                  fontWeight: isSelected[1] ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
