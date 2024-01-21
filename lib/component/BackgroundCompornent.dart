import 'package:flutter/material.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

// class BackgroundWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final screen = ScreenRef(context).watch(screenProvider);
//     return //Container(
//         //   color: Colors_compornet.globalBackgroundColorRed,
//         //   child: Stack(
//         //     children: [
//         //       // Positioned(
//         //       //   top: screen.designH(-250),
//         //       //   left: screen.designW(55),
//         //       //   child: Image.asset(
//         //       //     'assets/logo_images/BackgroundTimeImage.png',
//         //       //     width: screen.designH(570),
//         //       //     height: screen.designW(513),
//         //       //     fit: BoxFit.cover,
//         //       //   ),
//         //       // ),
//         //       Positioned(
//         //         // top: screen.designH(70),
//         //         // bottom: screen.designH(0),
//         //         // left: screen.designW(0),
//         //         // right: screen.designW(0),
//         //         child:
//         Container(
//       width: double.infinity,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors_compornet.globalBackgroundColorwhite,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(45),
//           topRight: Radius.circular(45),
//         ),
//       ),
//       //       ),
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }
class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors_compornet.globalBackgroundColorRed,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors_compornet.globalBackgroundColorwhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          border: Border(
            top: BorderSide.none, // 上線を非表示にする
          ),
        ),
        // 他のウィジェットやプロパティ設定
      ),
    );
  }
}

class CustamBackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Container(
      color: Colors_compornet.globalBackgroundColorRed,
      child: Stack(
        children: [
          Positioned(
            top: screen.designH(-250),
            left: screen.designW(55),
            child: Image.asset(
              'assets/logo_images/BackgroundTimeImage.png',
              width: screen.designH(570),
              height: screen.designW(513),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: screen.designH(80),
            bottom: screen.designH(0),
            left: screen.designW(0),
            right: screen.designW(0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors_compornet.globalBackgroundColorwhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
