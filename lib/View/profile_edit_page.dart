import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_alchemy_app/View/profile_page.dart';
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
      debugShowCheckedModeBanner: false,
      home: Profile_Edit_Page(),
    );
  }
}

class Profile_Edit_Page extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<Profile_Edit_Page> {
  late String userId = '';
  late String userName = '';
  late List<String> hobbyList = []; // データ型をList<String>に変更

  @override
  void initState() {
    super.initState();
    _getUserData();
    //_getUserID();
  }

  // ユーザーデータを取得する関数
  void _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userID') ?? '';
    });
    print('UserID: $userId');

    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      setState(() {
        userName = userData['user']['user_name'];
        hobbyList = List<String>.from(userData['hobby_user']['hobby_List']);
      });
    } catch (e) {
      print('Error: $e');
      // エラーが発生した場合の適切な処理をここに追加する
    }
  }

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
    // 名前
    final TextEditingController nameController = TextEditingController();
    // ID
    final TextEditingController IDController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 233, 226, 1),
      appBar: AppBarBrackTextButtonCompornent(
        //appBar
        leftText: 'キャンセル',
        title: 'プロフィールの編集',
        rightText: '完了',
        //TODO: appBarの遷移先書く
        //キャンセルボタン
        onPressedLeft: () => {
          // "戻る" ボタンが押されたときの処理
          Navigator.pop(context)
        },
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
            NameRow(
              label: '名前',
              value: userName,
              widthSize: 0.15,
              controller: nameController,
              onEditingComplete: (text) {
                // ここで編集が完了したときの処理を行う
                print('Name edited: $text');
              },
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
            NameRow(
              label: 'ユーザー名',
              value: userId,
              widthSize: 0.15,
              controller: IDController,
              onEditingComplete: (text) {
                // ここで編集が完了したときの処理を行う
                print('Name edited: $text');
              },
            ),
            BorderLine(),
            //趣味表示
            HobbyDisplay(hobbyList: hobbyList),
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
  final TextEditingController controller;
  final Function(String) onEditingComplete;

  const NameRow({
    required this.label,
    required this.value,
    this.labelFontSize = 14.0,
    this.valueFontSize = 17.0,
    required this.widthSize,
    required this.controller,
    required this.onEditingComplete,
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
        Spacer(),
        Container(
          width: screen.width * 0.7,
          height: screen.height * 0.04,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 8),
              fillColor: Colors_compornet.globalBackgroundColorwhite,
              filled: true,
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            onEditingComplete: () {
              widget.onEditingComplete(widget.controller.text);
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ],
    );
  }
}

// 趣味表示
class HobbyDisplay extends StatefulWidget {
  final List<String> hobbyList; // 変更: hobbyListをフィールドとして追加
  HobbyDisplay({required this.hobbyList}); // 変更: コンストラクターでhobbyListを受け取る
  @override
  _HobbyDisplayState createState() => _HobbyDisplayState();
}

class _HobbyDisplayState extends State<HobbyDisplay> {
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
                  for (int i = 0;
                      i < widget.hobbyList.length;
                      i++) // Change textContents to widget.hobbyList
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
                                widget.hobbyList.removeAt(
                                    i); // Change textContents to widget.hobbyList
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
                            widget.hobbyList[
                                i], // Change textContents to widget.hobbyList
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
