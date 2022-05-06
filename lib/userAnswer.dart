import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ito/gameMaster.dart';
import 'package:ito/userInfo.dart';
import 'package:ito/checkAnswer.dart';
import 'config.dart';

config _config;

// ignore: must_be_immutable, camel_case_types
class userAnswer extends StatefulWidget{
  userAnswer(this._itemUser,this._gameMaster);
  List<userInfo> _itemUser;
  gameMaster _gameMaster;

  @override
  State<StatefulWidget> createState() => _userAnswerState();
}

// ignore: camel_case_types
class _userAnswerState extends State<userAnswer> {


  // 現在ユーザを選択済みかどうか制御するためにindex番号を格納する変数
  int tempIndex;

  // ignore: must_call_super
  void initState(){
    // 回答一番目に正解の順番を格納したリストを作成
    // リストごと渡すと参照渡しになるためfor文で値渡しにする
    if(widget._gameMaster.currentOrderNo == 1){
      for(userInfo e in widget._itemUser){
        widget._gameMaster.resultUserList.add(e);
      }
      widget._gameMaster.resultUserList.sort((a,b) => a.cardNo.compareTo(b.cardNo));
    }
  }

  // 選択状態からユーザwidgetを返すメソッド
  // ignore: missing_return
  Widget _buildChildUserContainer(int index){
    switch(widget._itemUser[index].decidedStatus){
      case DecidedStatus.unDecided:
        return Container(
          width: _config.deviceWidth * 0.7,
          height: _config.deviceHeight * 0.055,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
              widget._itemUser[index].userName,
              style: TextStyle(fontSize: 20)
          ),
        );
      case DecidedStatus.currentDecide:
        return Container(
          width: _config.deviceWidth * 0.7,
          height: _config.deviceHeight * 0.055,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
            color: Colors.lightGreen,
          ),
          child: Text(
              widget._itemUser[index].userName,
              style: TextStyle(fontSize: 20)
          ),
        );
      case DecidedStatus.Decided:
        return Container(
          width: _config.deviceWidth * 0.7,
          height: _config.deviceHeight * 0.055,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
            color: Colors.grey,
          ),
          child: Text(
              widget._itemUser[index].userName,
              style: TextStyle(fontSize: 20)
          ),
        );
    }
  }

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
                    fontSize: 35,
                    color: Colors.grey
                ),
              ),
            ),
            SizedBox(height: _config.deviceHeight * 0.01,),
            Container(
              alignment: Alignment.center,
              height: _config.deviceHeight * 0.02,
              child: Text(
                "Order by ascending",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red
                ),
              ),
            ),
            SizedBox(height: _config.deviceHeight * 0.01,),
            Container(
              width: _config.deviceWidth * 0.8,
              height: _config.deviceHeight * 0.55,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  scrollDirection: Axis.vertical, // ListViewを縦方向にスクロール可能にするパラメータ
                  shrinkWrap: true,               // ListViewをColumn内で使用するために必要なパラメータ
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            // 各ユーザの選択状態を設定する
                            if(widget._itemUser[index].decidedStatus == DecidedStatus.unDecided){
                              if(tempIndex == null){
                                widget._itemUser[index].decidedStatus = DecidedStatus.currentDecide;
                              }
                              else{
                                widget._itemUser[tempIndex].decidedStatus = DecidedStatus.unDecided;
                                widget._itemUser[index].decidedStatus = DecidedStatus.currentDecide;
                              }
                              tempIndex = index;
                            }
                            else if(widget._itemUser[index].decidedStatus == DecidedStatus.currentDecide){
                              widget._itemUser[index].decidedStatus = DecidedStatus.unDecided;
                              tempIndex = null;
                            }
                            setState(() {});
                          },
                          child: _buildChildUserContainer(index)
                        ),
                        SizedBox(height: _config.deviceHeight * 0.008,)
                      ],
                    );
                  },
                  itemCount: widget._itemUser.length,
                ),
              ),
            ),
            SizedBox(height: _config.deviceHeight * 0.02,),
            // ユーザの答え順が確定していれば答え合わせ画面へ
            if(tempIndex != null)
              SizedBox(
                width: _config.deviceWidth * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    widget._itemUser[tempIndex].decidedStatus = DecidedStatus.Decided;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => checkAnswer(widget._itemUser,widget._itemUser[tempIndex],widget._gameMaster),
                      )
                    );
                    },
                  child: Text('MY ANSWER !!'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              )
            else
              SizedBox(
                width: _config.deviceWidth * 0.7,
                child: ElevatedButton(
                  onPressed: null,
                  child: Text('MY ANSWER !!'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

}