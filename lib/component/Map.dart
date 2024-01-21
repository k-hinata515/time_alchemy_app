import 'package:device_preview/device_preview.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Map(), // Wrap your app
      ),
);
class Map extends StatelessWidget {
  Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Map_Page(),
    );
  }
}
class Map_Page extends StatefulWidget {
  @override
  _Map_Page createState() => _Map_Page();
}

class _Map_Page extends State<Map_Page> {
  final data = [
    'assets/logo_images/ECCcanpas.png',
    'assets/logo_images/daisensou.png',
    'assets/logo_images/osakastation.png',
    'assets/logo_images/rinkutownstation.png',
    'assets/logo_images/mcdnald.png'
  ];
  final label = [
    'ECCコンピュータ専門学校',
    'ラーメン大戦争',
    '大阪駅',
    'りんくうタウン駅',
    'マクドナルド'
  ];
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screen.designH(40)),
            child: Container(
              child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: screen.designH(95),
                      decoration: BoxDecoration(
                        color: Colors_compornet.textfontColorWhite,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: screen.designW(8)),
                          Container(
                            height: screen.designH(45),
                            width: screen.designW(75),
                            decoration: BoxDecoration(
                              color: Colors_compornet.globalBackgroundColorRed,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                '現在地',
                                style: TextStyle(
                                  color: Colors_compornet.globalBackgroundColorwhite,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                   child: Row(
                                    children: [
                                       Container(
                                          height: screen.designH(3),
                                          width: screen.designW(70),
                                          color: Colors_compornet.globalBackgroundColorRed,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors_compornet.globalBackgroundColorRed,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              data[index],
                                              height: 50, // 任意の高さ
                                              width: 50, // 任意の幅
                                            ),
                                            Text(
                                              label[index],
                                              style: TextStyle(
                                                color: Colors_compornet.textfontcolorocher,
                                                fontSize: label.length > 5? screen.designH(5) :screen.designH(12)
                                              ),
                                              maxLines: 2,
                                            )
                                          ],
                                        )
                                        
                                    ],
                                   ),
                                  
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
}
