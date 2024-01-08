import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:time_alchemy_app/component/AppCompornent.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';
import 'package:time_alchemy_app/component/textformfield.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/screen_pod.dart';
import 'dart:math' as math;
import 'package:time_alchemy_app/component/PickerCoompornent.dart';
import 'package:time_alchemy_app/component/RatingBarCompornent.dart';

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

class FilterClass extends StatefulWidget {
  @override
  _FilterClassState createState() => _FilterClassState();
}

class _FilterClassState extends State<FilterClass> {
  bool isMenuOpen = false;
  String selectedFilter1 = '選択しない';
  String selectedFilter2 = '選択しない';
  String noSelected = '選択しない';

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

  void showFilterOptions1() {
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
                  updateSelectedFilter1(selectedOption);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showFilterOptions2() {
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
                  updateSelectedFilter2(selectedOption);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void updateSelectedFilter1(String newValue) {
    setState(() {
      selectedFilter1 = newValue;
    });
  }

  void updateSelectedFilter2(String newValue) {
    setState(() {
      selectedFilter2 = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
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
                    selectedFilter: selectedFilter1,
                    noSelected: noSelected,
                    onTap: showFilterOptions1,
                  ),
                  BorderLine(),
                  FilterButton(
                    label: '移動手段',
                    selectedFilter: selectedFilter2,
                    noSelected: noSelected,
                    onTap: showFilterOptions2,
                  ),
                  BorderLine(),
                  introAge(),
                  BorderLine(),
                  RatingEvaluation(),
                  BorderLine(),
                  SizedBox(
                    height: screen.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // 完了ボタン
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors_compornet.textfontColorWhite,
                          onPrimary: Colors_compornet.globalBackgroundColorRed,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15.0), // 角を丸くする半径を指定
                          ),
                        ),
                        child: Text('キャンセル'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //TODO: 絞り込み適用
                          print('Applied filter 1: $selectedFilter1');
                          print('Applied filter 2: $selectedFilter2');
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

class RatingEvaluation extends StatefulWidget {
  @override
  _RatingEvaluationState createState() => _RatingEvaluationState();
}

class _RatingEvaluationState extends State<RatingEvaluation> {
  @override
  Widget build(BuildContext context) {
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
          MyRatingBarWidget(),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        ],
      ),
    );
  }
}
