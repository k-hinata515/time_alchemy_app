import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import '../picker_list.dart';

class introAge extends StatefulWidget {
  String initialValue = '';
  @override
  introduce createState() => introduce();
}

class introduce extends State<introAge> {
  late String initialValue;

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _introAge();
  }

  String _selectedAge = "距離";
  String _initialAge = "選択しない";
  Widget _pickerAge(String str) {
    return Text(
      str,
      style: const TextStyle(fontSize: 32),
    );
  }

  Widget _introAge() {
    final screen = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Text(
            "移動範囲",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          CupertinoButton(
            child: Text(
              "${_initialAge}",
              style: TextStyle(
                fontSize: 15,
                color: _initialAge == _selectedAge
                    ? Colors_compornet.textfontColorBlack
                    : Colors_compornet.borderColorGray,
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: screen.height / 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CupertinoButton(
                              child: Text("戻る"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            CupertinoButton(
                              child: Text("決定"),
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  _initialAge = _selectedAge;
                                });
                              },
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: CupertinoPicker(
                            itemExtent: 40,
                            children: distanceList.map(_pickerAge).toList(),
                            onSelectedItemChanged: _onSelectedItemChanged_age,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          Transform(
            transform: Matrix4.rotationY(3.14159),
            child: Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
        ],
      ),
    );
  }

  void _onSelectedItemChanged_age(int index) {
    setState(() {
      _selectedAge = distanceList[index];
    });
  }
}
