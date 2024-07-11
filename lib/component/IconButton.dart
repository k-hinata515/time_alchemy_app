import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_alchemy_app/constant/Colors_comrponent%20.dart';
import 'package:time_alchemy_app/constant/screen_pod.dart';

class X_IconButton extends StatelessWidget {
  final String label;
  final String imageAsset;
  final GestureTapCallback onPressed;
  X_IconButton(
      {required this.label,
      required this.imageAsset,
      required this.onPressed}); //表示する　テキスト、画像、画面遷移先を引数として使う
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);

    return Container(
      height: screen.designH(40),
      width: screen.designW(300),
      child: Material(
        elevation: 10, // 影の強さを調整できます
        borderRadius: BorderRadius.circular(40),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Colors_compornet.globalBackgroundColorRed,
              width: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: screen.designW(40)),
              Image.asset(
                imageAsset,
                height: screen.designH(48),
                width: screen.designW(48),
              ),
              SizedBox(width: screen.designW(8)),
              Text(
                label,
                style: TextStyle(
                  color: Colors_compornet.textfontColorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Instagram_IconButton extends StatelessWidget {
  final String label;
  final String imageAsset;
  final GestureTapCallback onPressed;
  Instagram_IconButton(
      {required this.label,
      required this.imageAsset,
      required this.onPressed}); //表示する　テキスト、画像、画面遷移先を引数として使う
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);

    return Container(
      height: screen.designH(40),
      width: screen.designW(300),
      child: Material(
        elevation: 10, // 影の強さを調整できます
        borderRadius: BorderRadius.circular(40),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Colors_compornet.globalBackgroundColorRed,
              width: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: screen.designW(40)),
              Image.asset(
                imageAsset,
                height: screen.designH(48),
                width: screen.designW(48),
              ),
              SizedBox(width: screen.designW(8)),
              Text(
                label,
                style: TextStyle(
                  color: Colors_compornet.textfontColorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MapIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final double width;
  final double height;
  MapIconButton(
      {required this.onPressed, required this.width, required this.height});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width,
      onPressed: onPressed,
      child: Icon(
        Icons.location_on,
      ),
      padding: EdgeInsets.all(2),
      color: Colors_compornet.globalBackgroundColorRed,
      textColor: Colors_compornet.globalBackgroundColorwhite,
      shape: CircleBorder(),
    );
  }
}

class Search_Destination extends StatelessWidget{
  final VoidCallback onPressed;
  final double width;
  final double height;
  final String labeltext;
  final double icon_size;
  final TextEditingController destination_controller;
  final String hinttext;
  
  Search_Destination({required this.height, required this.width, required this.onPressed , required this.labeltext, required this.icon_size, required this.destination_controller ,required  this.hinttext}) ;
  
  @override
  Widget build(BuildContext context) {
    final screen = ScreenRef(context).watch(screenProvider);
    return Container(
      height: screen.designH(height),
      width: screen.designW(width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labeltext,
            style:TextStyle(
              fontSize: 12,
              color: Colors_compornet.textfontcolorocher,
            ),
          ),
          SizedBox(height:screen.designH(2) ,),
          Row(
            
            children: [
              Container(
                child: TextFormField(
                  controller: destination_controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10),
                    hintText: hinttext,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors_compornet.globalBackgroundColorRed
                      ),
                    )
                  ),
                ),
                
                height: screen.designH(height),
                width: screen.designW(width),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors_compornet.globalBackgroundColorwhite),
                  borderRadius: BorderRadius.circular(40)
                ),
                
              ),
              IconButton(
                onPressed: onPressed,
              icon: Icon(
                Icons.add_location_alt,
                size: icon_size,
                ),
              ),
            ],
          )
          
        ],
      ),
    );
  }

}

