import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ito/gameMaster.dart';
import 'package:ito/userInfo.dart';
import 'config.dart';

// ユーザの順番通りに格納する結果リスト
List<userInfo> resultUserList = <userInfo>[];

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

  // 結果リストの先頭からuserを格納するメソッド
  void resultUserAdd(userInfo user){
    resultUserList.add(user);
  }

  // 結果リストから指定したユーザを削除
  void resultUserRemove(userInfo user){
    resultUserList.remove(user);
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
                    // TODO : userInfoクラスでメソッド化
                    // TODO : 各ユーザが何番目かを判断できないためメソッド化は難しい
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            // 選択したユーザの順番が確定していなければリストに追加し番号を付与する
                            // そうでなければリストから削除し、リスト内に格納している他のユーザの順番を更新する
                          },
                          child: Container(
                            height: _config.deviceHeight * 0.055,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: _config.deviceWidth * 0.6,
                                  height: _config.deviceHeight * 0.055,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey)
                                  ),
                                  child: Text(
                                      widget._itemUser[index].userName,
                                      style: TextStyle(fontSize: 20)
                                  ),
                                ),
                                SizedBox(
                                    height: _config.deviceHeight * 0.03,
                                    width: _config.deviceWidth * 0.05,
                                    child: Text("q")
                                )
                              ],
                            ),
                          ),
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
            SizedBox(
              width: _config.deviceWidth * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  // TODO : 答え合わせ画面へ
                  Navigator.pop(context);
                },
                child: Text('MY ANSWER !!'),
                // TODO : 全員の順番を決定出来たら活性にする
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}