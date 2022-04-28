import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ito/numberCheck.dart';
import 'package:ito/userInfo.dart';
import 'package:ito/gameMaster.dart';
import 'package:ito/userAnswer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'config.dart';

config _config;

// ignore: must_be_immutable, camel_case_types
class openKeyword extends StatefulWidget{
  openKeyword(this._itemUser,this._gameMaster);
  List<userInfo> _itemUser;
  gameMaster _gameMaster;

  @override
  State<StatefulWidget> createState() => _openKeywordState();
}

// ignore: camel_case_types
class _openKeywordState extends State<openKeyword> {
  @override
  Widget build(BuildContext context) {
    _config = new config(context);
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: _config.deviceHeight * 0.1,),
            Row(
              children: <Widget>[
                SizedBox(width: _config.deviceWidth * 0.03,),
                for(int i = 0; i < widget._gameMaster.life; i++)
                  //Container(padding: EdgeInsets.all(2), child: Text('❤︎', style: TextStyle(color: Colors.red,fontSize: 20))),
                  Container(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  )
              ],
            ),
            SizedBox(height: _config.deviceHeight * 0.01,),
            Container(
              alignment: Alignment.center,
              height: _config.deviceHeight * 0.1,
              child: Text(
                'Question No.' + widget._gameMaster.questionNo.toString(),
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey
                ),
              ),
            ),
            SizedBox(height: _config.deviceHeight * 0.04,),
            Container(
              padding: EdgeInsets.all(20),
              height: _config.deviceHeight * 0.4,
              width: _config.deviceWidth * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    '人気な漫画',
                    textStyle: TextStyle(
                      fontSize: 32
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
            SizedBox(height: _config.deviceHeight * 0.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: MaterialButton(
                    height: _config.deviceHeight * 0.1,
                    minWidth: _config.deviceWidth * 0.1,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => numberCheck(widget._itemUser,widget._gameMaster),
                        fullscreenDialog: true
                      ));
                    },
                    color: Colors.blue,
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.format_list_numbered,
                      color: Colors.white,
                      size: _config.deviceWidth * 0.1,
                    ),
                  ),
                ),
                SizedBox(width: _config.deviceWidth * 0.2,),
                SizedBox(
                  height: _config.deviceHeight * 0.065,
                  width: _config.deviceWidth * 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => userAnswer(widget._itemUser,widget._gameMaster),
                      ));
                    },
                    child: Text('YOUR ANSWER'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}