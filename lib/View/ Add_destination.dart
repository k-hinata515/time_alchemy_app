import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:time_alchemy_app/component/BackgroundCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Add_destination(), // MyAppを直接指定
      ),
    );

class Add_destination extends StatelessWidget {
  Add_destination({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Add_destination_Page(),
    );
  }
}

class Add_destination_Page extends StatefulWidget {
  Add_destination_Page({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Add_destination_Page();
}

class _Add_destination_Page extends State<Add_destination_Page> {
  final TextEditingController searchtextfieldcontroller = TextEditingController();
  final List<String> narrow_down = [
    '評価順',
    'ランチ',
    '価格が低い',
  ];
  final List<Map<String ,dynamic>> testdata =[
      {'image':'assets/logo_images/kapparamen.png','label':'かっぱラーメン','evaluation':3, 'average':'1000'},
      {'image':'assets/logo_images/daisensou.png','label':'ラーメン大戦争','evaluation':4, 'average':'1000'},
      {'image':'assets/logo_images/zinrui.png','label':'人類皆麺類','evaluation':5, 'average':'1000'},
  ];
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    bool  is_Checked = false; //チェックボックスの状態管理 
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors_compornet.globalBackgroundColorRed,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors_compornet.globalBackgroundColorwhite,
        ),
        actions: [
          Container(
            width: screen.designW(200),
            height: screen.designH(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors_compornet.globalBackgroundColorwhite.withOpacity(0.85),
            ),
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: TabBar(
                unselectedLabelColor: Colors_compornet.textfontColorBlack,
                labelColor: Colors_compornet.globalBackgroundColorRed,
                indicator: BoxDecoration(
                  border: Border.all(color: Colors_compornet.textfontColorBlack),
                  borderRadius: BorderRadius.circular(12),
                ),
                tabs: <Widget>[
                  Tab(
                    text: 'おすすめ',
                  ),
                  Tab(
                    text: '趣味',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: screen.designW(100),
          )
        ],
      ),
      body: Stack(
        children: [
          CustamBackgroundWidget(),
          Column(
            children: [
              SizedBox(height: screen.designH(4)),
              Row(
                children: [
                  SizedBox(width: screen.designW(16)),
                  Container(
                    // width: screen.designW(100),
                    height: screen.designH(30),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.reorder,
                        size: 12,
                      ),
                      label: Text(
                        '絞り込み',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 12),
                        backgroundColor: Colors_compornet.narrow_down,
                        side: BorderSide(color: Colors_compornet.globalBackgroundColorwhite),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screen.designW(16)),
                  SearchTextField(
                    hintText: '例：ラーメン',
                    height: screen.designH(30),
                    width: screen.designW(200),
                    controller: searchtextfieldcontroller,
                  ),
                ],
              ),
              //SizedBox(height: screen.designH(16)),
              Container(
                height: screen.designH(50),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: narrow_down.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String narrow_down_tag = narrow_down[index];
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors_compornet.textfontcolorocher,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        border: Border.all(
                          width: screen.designW(5),
                          color: Colors.transparent,
                        ),
                      ),
                      child: Center(
                        child : FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                          '#$narrow_down_tag',
                          style: TextStyle(
                            color: Colors_compornet.globalBackgroundColorwhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                             
                          ),
                        ),
                        )
                        
                      ),
                      alignment: Alignment.center, // テキストを中央に配置
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: screen.designH(110)),
            child: Column(
              children: [
                Container(
                  height: screen.designH(500), // 仮の高さ。必要に応じて調整してください。
                  child: ListView.builder(
                    itemCount: testdata.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> data = testdata[index];
                      return Column(
                        children: [
                          Container(
                            width: screen.designW(300),
                            height: screen.designH(90),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors_compornet.globalBackgroundColorwhite.withOpacity(0.7),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 0.5,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: screen.designW(16)),
                                SizedBox(
                                  width: screen.designW(85),
                                  height: screen.designH(75),
                                  child: FittedBox(
                                    child: Image.asset(
                                      data['image'],
                                      width: screen.designW(85),
                                      height: screen.designW(75),
                                    ),
                                  ),
                                ),
                                SizedBox(width: screen.designW(16)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data['label'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '評価',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screen.designH(16),
                                          child: FittedBox(
                                            child: RatingBar.builder(
                                              initialRating: data['evaluation'].toDouble(),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Colors_compornet.textfontColorBlack,
                                              ),
                                              allowHalfRating: true,
                                              onRatingUpdate: (rating) {
                                                // 評価が更新された時の処理を書く
                                              },
                                              itemCount: 5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '平均¥${data['average']}',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: screen.designW(16)),
                                Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    value: is_Checked,
                                    onChanged: (value) {
                                      setState(() {
                                        is_Checked = value!;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: screen.designH(16)),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: screen.designH(16),),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ChoiceButtonRed(
                    text: '追加',
                    onPressed: (){
                      //追加を押した時の処理
                    },
                    height: 50,
                    width: 140,
                  ),
                )
              ],
            ),
            
          ),     
        ],
      ),
    );
  }
}