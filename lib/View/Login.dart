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
    builder: (context) => Login(), // Wrap your app
  ),
);

class Login extends StatelessWidget{
  Login({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: LoginPage(),
    );
  }

}
class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPage();
  
}
class _LoginPage extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);  //screenpodの処理
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      appBar: AppBarWhiteTextCompornent(
        title: 'ログイン',
        rightText: '次へ',
        onPressedLeft: () => {},
        onPressedRight: () => {},
        showRightText: false, //次へのアイコンを削除
      ),
      body: Stack(
        children: [
          BackgroundWidget(),
          Padding(
            padding:EdgeInsets.only(top:screen.designH(100)),//backgroundwidgetにあわせるに必要な余白
            child: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,  //垂直方こうに中央寄せ
                  children: [
                    MyTextFormField(
                      height: 40, 
                      width: 300, 
                      labelText: 'ユーザーID、メールアドレス、電話番号 ', 
                    ),
                    SizedBox(height:screen.designH(32),),
                    MyTextFormField(
                      labelText: 'パスワード', 
                      height: 40, 
                      width: 300
                    ),
                    SizedBox(height:screen.designH(24),
                    ),
                    ChoiceButtonRed(
                      text: 'ログイン', 
                      onPressed: ()=>{

                      },  
                      height: 150, 
                      width: 45
                      ),
                      SizedBox(height: screen.designH(16),),
                      Text(
                        'または',
                        style: TextStyle(
                          color: Colors_compornet.textfontColorGray,
                        ),
                      ),
                      SizedBox(height: screen.designH(24),),
                      TextButton(
                        onPressed: (){},
                        child: Text(
                          '＞新規登録はこちら',
                          style: TextStyle(
                            color: Colors_compornet.globalBackgroundColorRed,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: screen.designH(24),),
                      X_IconButton(
                        label: 'Xでログイン',
                        imageAsset: 'assets/logo_images/X_icon.png', 
                        onPressed: ()=>{
                            
                        }
                      ),
                      SizedBox(height: screen.designH(32),),
                      Instagram_IconButton(
                        label: 'Instagramでログイン',
                        imageAsset: 'assets/logo_images/Instagram_icon.png', 
                        onPressed: ()=>{

                        },
                      ),
                  ],
              ),
            ),
          ),
        ],
      ),
      // body:Column(
      //   children: [
      //     Center(
      //       child: MyTextFormField(
      //       height: 40, 
      //       width: 300, 
      //       labelText: 'ユーザーID、メールアドレス、電話番号 ', 
      //       )
      //     )
          

      //   ],
      // ),
    );
  }

}