import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';
import 'package:time_alchemy_app/logic/flutter/Hobby_Registration_b.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Hobby_Registration(), // Wrap your app
      ),
    );

class Hobby_Registration extends StatelessWidget {
  // コンストラクタ
  const Hobby_Registration({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SelectedHobby(
        username: '', // 仮のユーザー名
        emailOrPhoneNumber: '', // 仮のメールアドレスまたは電話番号
        password: '', // 仮のパスワード
      ),
    );
  }
}

class SelectedHobby extends StatefulWidget {
  final String username;
  final String emailOrPhoneNumber;
  final String password;

  // コンストラクタ
  const SelectedHobby({
    Key? key,
    required this.username,
    required this.emailOrPhoneNumber,
    required this.password,
  }) : super(key: key);

  @override
  State<SelectedHobby> createState() => _SelectedHobby();
}

class _SelectedHobby extends State<SelectedHobby> {
  List<String> tag = [];

  // 各タグの選択状態を管理するマップ
  var tagSelection = Map<String, bool>();

  @override
  void initState() {
    super.initState();
    _getHobbyIds();

    // 初期状態ではすべてのタグが未選択
    tag.forEach((currentTag) {
      tagSelection[currentTag] = false;
    });
  }

  Future<void> _getHobbyIds() async {
    final hobbyIds = await HobbyRegistrationB().getHobbyIds();
    setState(() {
      tag = hobbyIds;
      tag.forEach((currentTag) {
        tagSelection[currentTag] = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider); //screenpodの処理
    return Scaffold(
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      appBar: AppBarWhiteTextCompornent(
        title: '趣味・興味を選択',
        rightText: '次へ',
        onPressedLeft: () => {
          // "戻る" ボタンが押されたときの処理
          Navigator.pop(context)
          // Sign_Up_Page.dart に移動
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Sign_Up_Page()),
          // );
        },
        onPressedRight: () => {},
        showRightText: false, //右の
      ),
      body: Stack(
        children: [
          BackgroundWidget(),
          Positioned.fill(
            //スクロール可能領域の処理
            child: Padding(
              padding: EdgeInsets.only(top: screen.designH(75)), //上の余白
              child: GridView.builder(
                itemCount: tag.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //一列並べる個数
                  childAspectRatio: 2.0, //タグのアスペクト比率
                ),
                itemBuilder: (BuildContext context, int index) {
                  final String currentTag = tag[index];
                  final isSelected =
                      tagSelection[currentTag] ?? false; //選択されているかのフラグ
                  return InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      onTap: () {
                        // タグが選択されていれば非選択に、そうでなければ選択にする
                        setState(() {
                          tagSelection[currentTag] = !isSelected;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              border: Border.all(
                                width: 10,
                                color: Colors.transparent, //枠線の削除
                              ),
                              color: isSelected
                                  ? Colors_compornet
                                      .globalBackgroundColorRed //選択された時の枠組みのカラー
                                  : Colors_compornet
                                      .selectedtagdefault, //選択されていない時のカラー
                            ),
                            child: Center(
                              child: Text(
                                currentTag,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors_compornet
                                          .globalBackgroundColorwhite //選択された時のTextのカラー
                                      : Colors_compornet
                                          .textfontColorBlack, //選択されていない時のTextのカラー
                                  fontWeight: FontWeight.bold, //フォント
                                  fontSize: currentTag.length > 6 ?screen.designW(8) : screen.designW(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ),
          ),
          // 画面下部に配置されるボタン
          Positioned(
              bottom: 16,
              child: Container(
                width: MediaQuery.of(context).size.width, // 横幅を画面幅いっぱいに
                child: Center(
                  child: ChoiceButtonRed(
                    height: 45,
                    width: 120,
                    text: '次へ',
                    onPressed: () => _validateAndNavigate(context),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void _validateAndNavigate(BuildContext context) {
    searchNavigate(
      username: widget.username,
      emailOrPhoneNumber: widget.emailOrPhoneNumber,
      password: widget.password,
      selectedTags: tagSelection.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList(),
      context: context, // 追加
    );
  }
}
