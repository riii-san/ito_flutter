import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'config.dart';

// ignore: camel_case_types
class userInfo{

  // ユーザ固有番号
  int userId;
  // ユーザ名
  final String userName;
  // ユーザカード番号
  int cardNo;
  // ユーザカード画像パス
  String cardURL;
  // ユーザが既に順番を決めているのかどうか(列挙型)
  DecidedStatus decidedStatus = DecidedStatus.unDecided;

  userInfo(
      this.userId,
      this.userName,
      this.cardNo,
      this.cardURL
      );

  // ユーザ名とユーザ削除ボタンWidgetをセットで返すメソッド
  Widget returnUserWidget(void Function(int,String) userRemove , config _config){
    return Column(
      children: <Widget>[
        Container(
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
                    userName,
                    style: TextStyle(fontSize: 20)
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: _config.deviceHeight * 0.03,
                  width: _config.deviceWidth * 0.05,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          primary: Colors.grey
                      ),
                      onPressed: (){
                        userRemove(this.userId,this.userName);
                      },
                      child: Icon(Icons.cancel_rounded,color: Colors.white,)
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: _config.deviceHeight * 0.008,)
      ],
    );
  }

  // ユーザ名Widgetを返すメソッド
  // タップしたユーザの数字を返すメソッド
  Widget returnUserNumberWidget(config _config, var context){

    return Column(
      children: <Widget>[
        GestureDetector(
          // タップしたユーザの数字をダイアログで表示
          onTap: (){
            showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  content: Text("Are you " + this.userName + " ?" , style: TextStyle(fontSize: 18),),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text("No"),
                      isDestructiveAction: true,
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoDialogAction(
                      child: Text("Yes"),
                      // Yesを押下した場合、カードナンバーを違うダイアログで表示
                      onPressed: (){
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              content: Text("Your number is " + this.cardNo.toString() , style:  TextStyle(fontSize: 18),),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                    child: Text("OK"),
                                    onPressed: () => Navigator.pop(context)
                                ),
                              ],
                            );
                          },
                        );
                      }
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            height: _config.deviceHeight * 0.055,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: _config.deviceWidth * 0.7,
                  height: _config.deviceHeight * 0.055,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)
                  ),
                  child: Text(
                      userName,
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: _config.deviceHeight * 0.008,)
      ],
    );

  }


  // 数字を元にカードのパスを返すメソッド
  static String returnCardNumPath(int num){

    return 'images/' + num.toString() + '.png';

  }

  static String returnNoneCardPath(){

    return 'images/none.png';

  }

  static List<userInfo> returnInitializeUserDecidedStatusList(List<userInfo> recieveList){
    for(userInfo user in recieveList){
      user.decidedStatus = DecidedStatus.unDecided;
    }
    return recieveList;
  }

  static List<userInfo> returnInitializeUserList(List<userInfo> recieveList){
    recieveList.clear();
    return recieveList;
  }

}

enum DecidedStatus{
  unDecided,
  currentDecide,
  Decided
}