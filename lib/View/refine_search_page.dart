import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/picker_list.dart';
import 'package:time_alchemy_app/screen_pod.dart';
import 'dart:math' as math;

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(), // MyAppを直接指定
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FilterClass(),
    );
  }
}

class FilterClass extends StatefulWidget {
  @override
  _FilterClassState createState() => _FilterClassState();
}

class _FilterClassState extends State<FilterClass> {
  bool isMenuOpen = false;
  //屋内屋外用選択変数
  String selectedFilterInOrOut = '選択しない';
  //移動手段用選択変数
  String selectedFilterTransportation = '選択しない';
  //選択しない用変数
  String noSelected = '選択しない';
  //移動距離用変数
  String selectedFilterDistance = "選択しない";
  // 評価用変数
  double selectedFilterRating = 0;
  //評価の初期値用
  double initialRating = 0;

  late String initialValue;

  var selectedIndex = 0;

  List<Widget> buildPickerItems() {
    return distanceList.map((option) {
      return Text(option, style: const TextStyle(fontSize: 32));
    }).toList();
  }

  Widget pickerDistance(int index) {
    final String selectedOption = distanceList[index];
    return Text(
      selectedOption,
      style: const TextStyle(fontSize: 32),
    );
  }

  //評価(☆☆☆☆☆)
  Widget ratingbar() {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 17,
      itemBuilder: (context, index) {
        return const Icon(
          Icons.star,
          color: Colors.amber,
        );
      },
      onRatingUpdate: (index) {
        selectedFilterRating = index;
      },
    );
  }

  //評価選択全体表示
  Widget showSelectedFilterRating() {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
        left: 15,
        bottom: 5,
      ),
      child: Row(
        children: [
          Text(
            '評価',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          ratingbar(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ],
      ),
    );
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  void closeMenu() {
    setState(() {
      isMenuOpen = false;
    });
  }

  //屋内or屋外選択肢表示
  void showFilterInOrOut() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilterOptions(
                options: ['屋内', '屋外', '選択しない'],
                onSelect: (selectedOption) {
                  updateSelectedFilterInOrOut(selectedOption);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //移動方法選択肢表示
  void showFilterTransportation() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilterOptions(
                options: ['徒歩', '車', '選択しない'],
                onSelect: (selectedOption) {
                  updateSelectedFilterTransportation(selectedOption);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //検索距離選択肢表示
  void movingRange() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    FilterOptions(
                      options: [
                        "選択しない",
                        "100m以内",
                        "500m以内",
                        "1km以内",
                        "2km以内",
                        "3km以内",
                        "4km以内",
                        "5km以内",
                        "6km以内",
                        "7km以内",
                        "8km以内",
                        "9km以内",
                        "10km以内",
                      ],
                      onSelect: (selectedOption) {
                        updateSelected(selectedOption);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //屋内or屋外選択した値をセット
  void updateSelectedFilterInOrOut(String newValue) {
    setState(() {
      selectedFilterInOrOut = newValue;
    });
  }

  //移動方法選択した値をセット
  void updateSelectedFilterTransportation(String newValue) {
    setState(() {
      selectedFilterTransportation = newValue;
    });
  }

//移動距離選択した値をセット
  void updateSelected(String newValue) {
    setState(() {
      selectedFilterDistance = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          //メニュー表示
          GestureDetector(
            onTap: closeMenu,
            child: Container(
              color: isMenuOpen
                  ? Colors.black.withOpacity(0.5)
                  : Colors.transparent,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: screen.width * 0.25,
            bottom: 0,
            right: isMenuOpen ? 0 : -300,
            child: Container(
              width: screen.width * 0.77,
              decoration: BoxDecoration(
                color: Colors_compornet.globalBackgroundColorwhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70.0),
                  bottomLeft: Radius.circular(70.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screen.height * 0.02,
                  ),
                  Text(
                    '絞り込み',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: screen.height * 0.02,
                  ),
                  Divider(
                    color: Colors_compornet.borderColorGray,
                    thickness: 1.0,
                  ),
                  FilterButton(
                    label: '屋内or屋外',
                    selectedFilter: selectedFilterInOrOut,
                    noSelected: noSelected,
                    onTap: showFilterInOrOut,
                  ),
                  BorderLine(),
                  FilterButton(
                    label: '移動手段',
                    selectedFilter: selectedFilterTransportation,
                    noSelected: noSelected,
                    onTap: showFilterTransportation,
                  ),
                  BorderLine(),
                  FilterButton(
                    label: '移動',
                    selectedFilter: selectedFilterDistance,
                    noSelected: noSelected,
                    onTap: movingRange,
                  ),
                  BorderLine(),
                  showSelectedFilterRating(),
                  BorderLine(),
                  SizedBox(
                    height: screen.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // キャンセルボタン
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors_compornet.textfontColorWhite,
                          onPrimary: Colors_compornet.globalBackgroundColorRed,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15.0), // 角を丸くする半径を指定
                          ),
                        ),
                        child: Text('キャンセル'),
                        onPressed: () {
                          //メニュー閉じる
                          closeMenu();
                        },
                      ),
                      //完了ボタン
                      ElevatedButton(
                        onPressed: () {
                          //TODO: 絞り込み適用
                          //屋内or屋外 選択値表示
                          print('Applied filter 1: $selectedFilterInOrOut');
                          //移動手段 選択値表示
                          print(
                              'Applied filter 2: $selectedFilterTransportation');
                          //移動範囲 選択値表示
                          print(
                              'Selected MovingDistance: $selectedFilterDistance');
                          //評価 選択値表示
                          print('Selected Rating: $selectedFilterRating');
                          closeMenu();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors_compornet.globalBackgroundColorRed,
                          onPrimary: Colors_compornet.textfontColorWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15.0), // 角を丸くする半径を指定
                          ),
                        ),
                        child: Text('完了'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 200,
            child: GestureDetector(
              onTap: toggleMenu,
              child: isMenuOpen
                  ? SizedBox.shrink()
                  : Row(
                      children: [
                        Text(
                          '絞り込み',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

//選択した値表示
class FilterButton extends StatelessWidget {
  final String label;
  final String selectedFilter;
  final String noSelected;
  final Function onTap;

  FilterButton({
    required this.label,
    required this.selectedFilter,
    required this.noSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(70.0),
          bottomLeft: Radius.circular(70.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              selectedFilter == '' ? noSelected : selectedFilter,
              style: TextStyle(
                color: selectedFilter == noSelected ? Colors.grey : null,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14159),
              child: Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          ],
        ),
      ),
    );
  }
}

//ボーダーライン
class BorderLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0),
      child: const Divider(
        color: Colors_compornet.borderColorGray,
        thickness: 1.0,
      ),
    );
  }
}

//下の方に選択肢表示
class FilterOptions extends StatelessWidget {
  final List<String> options;
  final Function(String) onSelect;

  FilterOptions({
    required this.options,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (index) {
          final option = options[index];

          return ListTile(
            title: Text(option),
            onTap: () {
              onSelect(option);
              Navigator.pop(context); // Close the bottom sheet
            },
          );
        }),
      ),
    );
  }
}
