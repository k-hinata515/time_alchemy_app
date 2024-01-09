import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/IconButton.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

void main () => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => Sign_Up(), // Wrap your app
  ),
);

class Sign_Up extends StatelessWidget{
  Sign_Up({Key? key}) : super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Sign_Up_Page(),
    );
  }
}
class Sign_Up_Page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Sign_Up_Page();

}
class _Sign_Up_Page extends State<Sign_Up_Page>{
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);  //screenpodの処理
    return Scaffold(
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      appBar: AppBarWhiteTextCompornent(
        title: '新規登録',
        rightText: '次へ',
        onPressedLeft: () => {},
        onPressedRight: () => {},
        showRightText: false, //次へのアイコ
      ),
      body: Stack(
        children: [
          BackgroundWidget(),
          Padding(
            padding: EdgeInsets.only(top:screen.designH(100)),  //backgroundwidgetにあわせるに必要な余白
            child: Center(
              child: Column(
                children: [
                   MyTextFormField(
                      height: 40, 
                      width: 300, 
                      labelText: 'ユーザー名 ', 
                    ),
                    SizedBox(height:screen.designH(24),),
                     MyTextFormField(
                      height: 40, 
                      width: 300, 
                      labelText: 'メールアドレスまたは電話番号', 
                    ),
                    SizedBox(height:screen.designH(24),),
                     MyTextFormField(
                      height: 40, 
                      width: 300, 
                      labelText: 'パスワード', 
                    ),
                    SizedBox(height:screen.designH(24),),
                    ChoiceButtonRed(
                       text: '次へ', 
                      onPressed: ()=>{

                      },  
                      height: 150, 
                      width: 45,
                      ),
                      SizedBox(height:screen.designH(24),),
                      Text(
                        'または',
                        style: TextStyle(
                          color: Colors_compornet.textfontColorGray,
                        ),
                      ),
                      SizedBox(height:screen.designH(32),),
                      X_IconButton(
                        label: 'Xでログイン',
                        imageAsset: 'assets/logo_images/X_icon.png', 
                        onPressed: ()=>{
                            
                        }
                      ),
                      SizedBox(height: screen.designH(24),),
                      Instagram_IconButton(
                        label: 'Instagramでログイン',
                        imageAsset: 'assets/logo_images/Instagram_icon.png', 
                        onPressed: ()=>{

                        },
                      ),

                ],
              ),
            ),
            )
        ],
      ),
    );
  }

}