import 'package:flutter/material.dart';

// ゲーム参加ユーザが格納されているリスト
// TODO : グローバル宣言でも良いのか
List<userInfo> _itemUser = <userInfo>[];

// ユーザ一人分の情報を持つクラス
// 参加ユーザ分のインスタンスを生成
// ignore: camel_case_types
class userInfo{

  final int userId;
  final String userName;

  userInfo(
      this.userId,
      this.userName,
      );

  Widget returnUserWidget(){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 270,
              height: 50,
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
                height: 25,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.grey
                    ),
                    onPressed: (){
                      // TODO : リストからユーザ削除、再描画
                      _itemUser.removeAt(userId);
                    },
                    child: Icon(Icons.cancel_rounded,color: Colors.white,)
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 5,)
      ],
    );
  }


}

// ignore: camel_case_types, must_be_immutable
class gameStartPage extends StatefulWidget {

  @override
  _gameStartPageState createState() => _gameStartPageState();

}

// ignore: camel_case_types
class _gameStartPageState extends State<gameStartPage> {

  // ユーザ名を格納するリスト
  // ユーザ追加する際に同じ名前があればfalseを返す必要があるため
  // TODO : _itemUserだけで実装できないか??
  List<String> _userNameList = <String>[];

  // ユーザ追加テキストボックス内の文字を把握するコントローラー
  final valueUserNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // add user テキストフィールド
                    Container(
                      width: 300,
                      height: 50,
                      child: TextFormField(
                        controller: valueUserNameController,
                        decoration: InputDecoration(
                          hintText: 'add user',
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2.0
                            ),
                          ),
                        ),
                      ),
                    ),
                    // プラスボタン
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                          ),
                          onPressed: (){
                            // ユーザ名がnull且つユーザリストにある名前でない場合にゲーム参加リストに追加
                            if (valueUserNameController.text.isNotEmpty && !_userNameList.contains(valueUserNameController.text)) {
                              _itemUser.add(new userInfo(_itemUser.length, valueUserNameController.text));
                              _userNameList.add(valueUserNameController.text);
                              setState(() {});
                            }
                          },
                          child: Icon(Icons.add,)
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40,),
                // UserListテキスト
                Text(
                  'User List',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey
                  ),
                ),
                // UserList表示領域(スクロール可)
                Container(
                  width: 350,
                  height: 500,
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
                        return _itemUser[index].returnUserWidget();
                      },
                      itemCount: _itemUser.length,
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // CANCELボタン
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      },
                        child: Text(
                            'CANCEL'
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black12
                        ),
                      ),
                    ),
                    // STARTボタン
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      },
                        child: Text(
                            'START'
                        ),
                      ),
                    ),
                  ],
                )
              ]
          ),
        )
    );
  }
}


