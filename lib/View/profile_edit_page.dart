import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/screen_pod.dart';
import 'package:time_alchemy_app/view/profile_page.dart'; // 修正

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileEditPage(), // 修正
    );
  }
}

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  // 写真表示領域をタップしたときに写真を選ぶ
  void _selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);

    return Scaffold(
      //backgroundColor: Colors_compornet.globalBackgroundColorwhite,
      appBar: AppBarBrackTextButtonCompornent(
        //appBar
        leftText: 'キャンセル',
        title: 'プロフィールの編集',
        rightText: '完了',
        onPressedLeft: () => {},
        onPressedRight: () => {},
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackgroundWidget(),
            // 写真表示領域をタップしたときに写真を選ぶように変更
            GestureDetector(
              onTap: _selectImage,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: screen.designH(100),
                  height: screen.designH(100),
                  child: _image == null
                      ? Center(
                          child: ClipOval(
                            child: Image.asset(
                              'assets/logo_images/no_image.jpg', // 画像ファイルのパス
                              width: screen.designH(100),
                              height: screen.designH(100),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : ClipOval(
                          child: Image.file(
                            _image!,
                            width: screen.designH(100),
                            height: screen.designH(100),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            const Divider(
              color: Colors_compornet.borderColorGray, // ボーダーラインの色
              thickness: 1.0, // ボーダーラインの太さ
            ),
          ],
        ),
      ),
    );
  }
}

// class borderLine extends StatelessWidget {
//   Widget build(BuildContext context) {}
// }
