import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';
import 'package:time_alchemy_app/screen_pod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/rendering/stack.dart';

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
      home: ProfileEditPage(),
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
      backgroundColor: Colors_compornet.globalBackgroundColorwhite,
      appBar: AppBarBrackTextButtonCompornent(
        //appBar
        leftText: 'キャンセル',
        title: 'プロフィールの編集',
        rightText: '完了',
        //TODO: appBarの遷移先書く
        //キャンセルボタン
        onPressedLeft: () => {},
        //完了ボタン
        onPressedRight: () => {},
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 写真表示領域をタップしたときに写真を選ぶ
            GestureDetector(
              onTap: _selectImage,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
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
            BorderLine(),
            //名前
            const NameRow(
              label: '名前',
              value: 'tanaso',
              widthSize: 0.15,
            ),
            SizedBox(
              height: screen.designH(10),
            ),
            ShortBorderLine(
              width: screen.designW(308),
            ),
            SizedBox(
              height: screen.designH(10),
            ),
            //ユーザーＩＤ
            const NameRow(
              label: 'ユーザーID',
              value: 'tana.2220029',
              widthSize: 0.08,
            ),
            BorderLine(),
            //趣味表示
            HobbyDisplay(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(right: 17.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0), // 丸い角を指定
                  color: Colors_compornet.globalBackgroundColorRed,
                ),
                child: TextButton(
                  //TODO: 追加ボタン遷移先
                  onPressed: () => (),
                  child: const Text(
                    '追加',
                    style:
                        TextStyle(color: Colors_compornet.textfontColorWhite),
                  ),
                ),
              ),
            ),

            BorderLine(),
            // 個人情報の設定ボタン
            Align(
              alignment: Alignment.centerLeft, // 左詰めに配置
              child: TextButton(
                //TODO: 個人情報の設定ボタン遷移先
                onPressed: () => (),
                child: const Text(
                  '個人情報の設定',
                  style: TextStyle(
                    color: Colors_compornet.globalBackgroundColorRed,
                    fontSize: 14.0, // 適切なフォントサイズに調整
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//名前、ユーザＩＤ表示
class NameRow extends StatefulWidget {
  final String label;
  final String value;
  final double labelFontSize;
  final double valueFontSize;
  final double widthSize;

  const NameRow({
    required this.label,
    required this.value,
    this.labelFontSize = 14.0,
    this.valueFontSize = 17.0,
    required this.widthSize,
  });

  @override
  _NameRowState createState() => _NameRowState();
}

class _NameRowState extends State<NameRow> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Row(
      children: [
        SizedBox(
          width: screen.width * 0.03,
        ),
        Text(
          widget.label,
          style: TextStyle(
            color: Colors.black, // ここに適切な色を指定
            fontSize: widget.labelFontSize,
          ),
        ),
        SizedBox(
          width: screen.width * widget.widthSize,
        ),
        Text(
          widget.value,
          style: TextStyle(
            color: Colors.black, // ここに適切な色を指定
            fontSize: widget.valueFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// 趣味表示
class HobbyDisplay extends StatefulWidget {
  @override
  _HobbyDisplayState createState() => _HobbyDisplayState();
}

class _HobbyDisplayState extends State<HobbyDisplay> {
  List<String> textContents = [
    "ゲーム",
    "太鼓の達人",
    "パソコン",
    "ああああ",
    "携帯ゲーム",
    "aaaaaaaaaaaa",
  ];

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Row(
      children: [
        SizedBox(
          height: 30,
          width: screen.width * 0.03, // 右側の余白を設定
        ),
        const Text(
          '趣味',
          style: TextStyle(
            fontSize: 16,
            color: Colors_compornet.textfontColorBlack,
          ),
        ),
        SizedBox(
          height: 5,
          width: screen.width * 0.11, // 右側の余白を設定
        ),
        Expanded(
          // 追加: Expanded ウィジェットを追加
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                spacing: screen.width * 0.015,
                runSpacing: screen.height * 0.01,
                children: [
                  for (int i = 0; i < textContents.length; i++)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors_compornet.globalBackgroundColorRed,
                          width: 1.0,
                        ),
                        color: Colors_compornet.globalBackgroundColorwhite,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                textContents.removeAt(i);
                              });
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors_compornet.borderColorGray,
                              size: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            textContents[i],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors_compornet.textfontColorBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//ボーダーライン
class BorderLine extends StatelessWidget {
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors_compornet.borderColorGray, // ボーダーラインの色
      thickness: 1.0, // ボーダーラインの太さ
    );
  }
}

//ボーダーラインshort
class ShortBorderLine extends StatelessWidget {
  final double width;

  const ShortBorderLine({
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 1.0, // ボーダーラインの高さ
        color: Colors_compornet.borderColorGray, // ボーダーラインの色
        width: width,
      ),
    );
  }
}
