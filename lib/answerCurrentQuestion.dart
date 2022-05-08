import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ito/gameEnd.dart';
import 'package:ito/gameMaster.dart';
import 'package:ito/userAnswer.dart';
import 'package:ito/userCheckNumber.dart';
import 'package:ito/userInfo.dart';
import 'config.dart';
import 'dart:async';

config _config;

// ignore: must_be_immutable, camel_case_types
class answerCurrentQuestion extends StatefulWidget{
  answerCurrentQuestion(this._itemUser,this._gameMaster);
  List<userInfo> _itemUser;
  gameMaster _gameMaster;

  @override
  State<StatefulWidget> createState() => _answerCurrentQuestionState();
}

// ignore: camel_case_types
class _answerCurrentQuestionState extends State<answerCurrentQuestion> {

  @override
  Widget build(BuildContext context) {
    _config = new config(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: _config.deviceHeight * 0.1,),
            Row(
              children: <Widget>[
                SizedBox(width: _config.deviceWidth * 0.03,),
                for(int i = 0; i < widget._gameMaster.life; i++)
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
                    fontSize: _config.deviceWidth / 12,
                    color: Colors.grey
                ),
              ),
            ),
            // ↓ここからユーザ名とカードを表示
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(widget._gameMaster.resultUserList[0].userName),
                    returnNumCard(widget._gameMaster.resultUserList[0].cardURL)
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(widget._gameMaster.resultUserList[1].userName),
                    returnNumCard(widget._gameMaster.resultUserList[1].cardURL)
                  ],
                ),
                Column(
                    children: <Widget>[
                      Text(widget._gameMaster.resultUserList[2].userName),
                      returnNumCard(widget._gameMaster.resultUserList[2].cardURL)
                    ]
                ),
              ],
            ),
            SizedBox(height: _config.deviceHeight * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    children: <Widget>[
                      Text(widget._gameMaster.resultUserList[3].userName),
                      returnNumCard(widget._gameMaster.resultUserList[3].cardURL)
                    ]
                ),
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.resultUserList.length < 5)
                        Text("")
                      else
                        Text(widget._gameMaster.resultUserList[4].userName),
                      if(widget._gameMaster.resultUserList.length < 5)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[4].cardURL)
                    ]
                ),
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.resultUserList.length < 6)
                        Text("")
                      else
                        Text(widget._gameMaster.resultUserList[5].userName),
                      if(widget._gameMaster.resultUserList.length < 6)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[5].cardURL)
                    ]
                ),
              ],
            ),
            SizedBox(height: _config.deviceHeight * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.resultUserList.length < 7)
                        Text("")
                      else
                        Text(widget._gameMaster.resultUserList[6].userName),
                      if(widget._gameMaster.resultUserList.length < 7)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[6].cardURL)
                    ]
                ),
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.resultUserList.length < 8)
                        Text("")
                      else
                        Text(widget._gameMaster.resultUserList[7].userName),
                      if(widget._gameMaster.resultUserList.length < 8)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[7].cardURL)
                    ]
                ),
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.resultUserList.length < 9)
                        Text("")
                      else
                        Text(widget._gameMaster.resultUserList[8].userName),
                      if(widget._gameMaster.resultUserList.length < 9)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[8].cardURL)
                    ]
                ),
              ],
            ),
            SizedBox(height: _config.deviceHeight * 0.03,),
            // ライフが残っていれば次の問題へ
            if(widget._gameMaster.life > 0)
              SizedBox(
                width: _config.deviceWidth * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    widget._gameMaster.resultUserList.clear();
                    widget._gameMaster.questionNo++;
                    Navigator.push(context, MaterialPageRoute(
                        // ユーザカード確認画面へ
                        builder: (context) => userCheckNumber(widget._itemUser,widget._gameMaster),
                    )
                    );
                  },
                  child: Text('NEXT QUESTION'),
                ),
              )
            else if (widget._gameMaster.life == 0)
              SizedBox(
                width: _config.deviceWidth * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => gameEnd(false),
                    )
                    );
                  },
                  child: Text('GAME END'),
                ),
              )
          ],
        ),
      ),
    );
  }
}

Widget returnNoneCard(String cardURL){
  return Image.asset(cardURL,height: _config.deviceHeight * 0.18,);
}

Widget returnNumCard(String cardURL){
  return Image.asset(cardURL,height: _config.deviceHeight * 0.18,);
}
