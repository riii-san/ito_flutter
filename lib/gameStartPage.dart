import 'package:flutter/material.dart';
import 'package:ito/userInfo.dart';
import 'package:ito/gameMaster.dart';
import 'package:ito/userCheckNumber.dart';
import 'config.dart';


// ignore: camel_case_types, must_be_immutable
class gameStartPage extends StatefulWidget {

  @override
  _gameStartPageState createState() => _gameStartPageState();

}

// ignore: camel_case_types
class _gameStartPageState extends State<gameStartPage> {

  // ゲーム参加ユーザが格納されているリスト
  List<userInfo> _itemUser = <userInfo>[];
  // ユーザがカードをめくる番号、問題番号、残りライフ
  gameMaster _gameMaster = gameMaster(0,1,3);

  // ユーザ名を格納するリスト
  // ユーザ追加する際に同じ名前があればfalseを返す必要があるため
  // TODO : _itemUserだけで実装できないか??
  List<String> _userNameList = <String>[];

  // ユーザ追加テキストボックス内の文字を把握するコントローラー
  final valueUserNameController = TextEditingController();

  // ユーザ情報を削除するメソッド
  void userRemove(int userId,String userName){
    _itemUser.removeAt(userId);
    _userNameList.remove(userName);
    // TODO : foreach且つアロー演算子で記述する
    for(int i = 0; i < _itemUser.length; i++){
      _itemUser[i].userId = i;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    config _config = new config(context);
    return Scaffold(
        body : Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: _config.deviceHeight * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // add user テキストフィールド
                      Container(
                        width: _config.deviceWidth * 0.7,
                        child: TextFormField(
                          controller: valueUserNameController,
                          decoration: InputDecoration(
                            hintText: 'add user name',
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
                      if(_userNameList.length < 9)
                        SizedBox(
                          child: MaterialButton(
                            height: _config.deviceHeight * 0.1,
                            minWidth: _config.deviceWidth * 0.1,
                            onPressed: (){
                              if (valueUserNameController.text.isNotEmpty && !_userNameList.contains(valueUserNameController.text)) {
                                _itemUser.add(new userInfo(_itemUser.length, valueUserNameController.text, null,null));
                                _userNameList.add(valueUserNameController.text);
                                valueUserNameController.clear();
                                setState(() {});
                              }
                            },
                            color: Colors.blue,
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      else
                        // TODO : 非活性にするとボタンが消える
                        MaterialButton(
                          height: _config.deviceHeight * 0.1,
                          minWidth: _config.deviceWidth * 0.1,
                          onPressed: (){},
                          color: Colors.black12,
                          shape: CircleBorder(),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(height: _config.deviceHeight * 0.025,),
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
                        return _itemUser[index].returnUserWidget(userRemove, _config);
                      },
                      itemCount: _itemUser.length,
                    ),
                  ),
                ),
                SizedBox(height: _config.deviceHeight * 0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // CANCELボタン
                    SizedBox(
                      width: _config.deviceWidth * 0.4,
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
                    // ユーザが4人以上参加した場合のみゲームを開始するようにする
                    if(_itemUser.length > 3)
                      SizedBox(
                        width: _config.deviceWidth * 0.4,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                // 引数 : ユーザリスト、ユーザ番号(orderNo)、問題番号、残り体力
                                builder: (context) => userCheckNumber(_itemUser,_gameMaster)
                            ));

                          },
                          child: Text(
                              'START'
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: _config.deviceWidth * 0.4,
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black12
                          ),
                          child: Text(
                              'START'
                          ),
                        ),
                      )
                  ],
                )
              ]
          ),
        )
    );
  }
}


