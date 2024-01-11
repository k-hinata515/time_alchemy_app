import 'package:flutter/material.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

class Dashed_Line extends StatelessWidget {
  final double height;
  final double width;
  
  Dashed_Line({required this.height, required this.width});
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Container(
       height: height,// 破線の高さ
       width: width,  //破線の幅
      child: CustomPaint(
        painter: DashedLinePainter(),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors_compornet.textfontcolorocher // 破線の色
      ..strokeWidth = 2.0 // 線の太さ
      ..strokeCap = StrokeCap.round; // 線の先端を丸く

    final double dashWidth = 5.0; // 破線1つ分の幅
    final double dashSpace = 3.0; // 破線と破線の間隔

    double startY = 0.0;
    
    // 縦の破線を描画
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
