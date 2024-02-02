import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_alchemy_app/View/profile_edit_page.dart';
import 'package:time_alchemy_app/View/search.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(), // MyAppを直接指定
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      home: ProfileEditPage(),
    );
  }
}

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late String userId = '';
  late String userName = '';
  late List<String> hobbyList = []; // データ型をList<String>に変更

  @override
  void initState() {
    super.initState();
    _getUserData();
    //_getUserID();
  }

  // ユーザーIDを取得する関数
  // void _getUserID() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     userId = prefs.getString('userID') ?? ''; // Handle null case
  //   });
  //   print('UserID: $userId'); // ユーザーIDをコンソールに表示
  // }

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

      print(userName);
      print(hobbyList);
    } catch (e) {
      print('Error: $e');
      // エラーが発生した場合の適切な処理をここに追加する
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);

    return Scaffold(
      backgroundColor: Colors_compornet.globalBackgroundColorwhite,
      body: Stack(
        children: [
          AppBackground(),
          HobbyDisplay(hobbyList: hobbyList),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screen.designH(127)),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundImage: AssetImage(
                          'assets/logo_images/no_image.jpg',
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors_compornet.textfontColorWhite,
                        ),
                      ),
                      SizedBox(height: 2.0), // 追加の余白
                      Text(
                        userId,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors_compornet.textfontColorWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ProfileAppBarCompornent(
            title: 'プロフィール',
            rightText: '編集',
            onPressedLeft: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              )
            },
            onPressedRight: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile_Edit_Page()),
              )
            },
          ),
        ],
      ),
    );
  }
}

// 茶色背景
class AppBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final height = constraint.maxHeight;
      final width = constraint.maxWidth;

      return Stack(
        children: <Widget>[
          Positioned(
            top: -height * 0.4,
            left: -height * 0.05,
            child: Container(
              height: height + 70,
              width: width + 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors_compornet.globalBackgroundColorRed.withOpacity(1),
              ),
            ),
          ),
        ],
      );
    });
  }
}

// 趣味表示
class HobbyDisplay extends StatelessWidget {
  final List<String> hobbyList; // 変更: hobbyListをフィールドとして追加
  HobbyDisplay({required this.hobbyList}); // 変更: コンストラクターでhobbyListを受け取る

  @override
  Widget build(BuildContext context) {
    final textContents = hobbyList;

    // 各要素の前に「・」を追加
    final formattedContents = textContents.map((text) => '・ $text').toList();

    return LayoutBuilder(builder: (context, constraint) {
      return Column(
        children: [
          SizedBox(height: 380),
          Text(
            '趣味',
            style: TextStyle(
              fontSize: 16,
              color: Colors_compornet.globalBackgroundColorRed,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors_compornet.globalBackgroundColorRed,
                  width: 2.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < textContents.length; i++)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        formattedContents[i],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors_compornet.globalBackgroundColorRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
