import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

class ClockMenu extends StatefulWidget {
  @override
  _ClockMenu createState() => _ClockMenu();
}

class _ClockMenu extends State<ClockMenu> {
  bool drawShape = false;
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return GestureDetector(
      onTap: () {
        setState(() {
          drawShape = false;
        });
      },
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: screen.designH(10),
            right: screen.designW(20),
            child: SizedBox(
              height: screen.designH(45),
              width: screen.designW(45),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    drawShape = !drawShape;
                  });
                }, child: Image(
                  image: AssetImage('logo_images/icon.png'),
                ),
                 style: ElevatedButton.styleFrom(
                primary: Colors_compornet.textfontColorWhite,
                shape: CircleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
              ),
                // style: ElevatedButton.styleFrom(
                //   primary: Color.fromARGB(255, 194, 195, 185),
                //   shape: CircleBorder(
                //     side: BorderSide(
                //       width: 4,
                //       color: Colors.black,
                //     ),
                //   ),
                // ).merge(ButtonStyle(
                //   minimumSize: MaterialStateProperty.all(Size(20, 20)),
                // )),
                // child: Image.asset('logo_images/icon.png'),
              ),
            )
            
          ),

          // カスタムペイント1
          Positioned(
              bottom: 0,
              right: 0,
              child: CustomPaint(
                  painter: drawShape
                      ? Painter(
                          radius: 140.0,
                          color: Color.fromRGBO(120, 89, 79, 1),
                        )
                      : null)),

          // カスタムペイント2
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomPaint(
                painter: drawShape
                    ? Painter(
                        radius: 105.0,
                        color: Color.fromRGBO(242, 235, 228, 1.0),
                      )
                    : null),
          ),
          //長針
          Positioned(
              bottom: 30,
              right: 30,
              child: Visibility(
                visible: drawShape,
                child: Image.asset('logo_images/longhand.png'),
              )),
          //短針
          Positioned(
              bottom: 30,
              right: 30,
              child: Visibility(
                visible: drawShape,
                child: Image.asset(
                  'logo_images/hourhand.png',
                ),
              )),
          //設定ボタン
          Positioned(
            bottom: 30,
            right: 170,
            child: Visibility(
                visible: drawShape,
                child: HoverButton(
                  buttonIcon: Icons.settings,
                )),
          ),
          //検索ボタン
          Positioned(
            bottom: 90,
            right: 173,
            child: Visibility(
                visible: drawShape,
                child: HoverButton(
                  buttonIcon: Icons.search,
                )),
          ),
          //ホームボタン
          Positioned(
            bottom: 140,
            right: 150,
            child: Visibility(
                visible: drawShape,
                child: HoverButton(
                  buttonIcon: Icons.home,
                )),
          ),
          //プロフィールボタン
          Positioned(
            bottom: 175,
            right: 105,
            child: Visibility(
                visible: drawShape,
                child: HoverButton(
                  buttonIcon: Icons.person,
                )),
          ),
          //多分マップボタン
          Positioned(
            bottom: 185,
            right: 45,
            child: Visibility(
              visible: drawShape,
              child: HoverButton(
                buttonIcon: Icons.room,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HoverButton extends StatefulWidget {
  final IconData buttonIcon;
  HoverButton({required this.buttonIcon});
  @override
  _HoverButton createState() => _HoverButton();
}

class _HoverButton extends State<HoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: GestureDetector(
        onTap: () {
          print('押されました');
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          width: isHovered ? 60.0 : 35.0,
          height: isHovered ? 60.0 : 35.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 235, 233, 227),
            border: Border.all(
              color: Colors.black, // 縁の色を指定
              width: 2.0, // 縁の幅を指定
            ),
          ),
          child: Center(
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                child: Icon(
                  widget.buttonIcon,
                  size: isHovered ? 45.0 : 27.0,
                )),
          ),
        ),
      ),
    );
  }
}

class Painter extends CustomPainter {
  final double radius;
  final Color color;

  Painter({required this.radius, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    // 円を描画
    Paint paint = Paint()
      ..color = color // 色を設定
      ..style = PaintingStyle.fill;

    //円の中心を決めてる
    canvas.drawCircle(
      Offset(-70, -80),
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
