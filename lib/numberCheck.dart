import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ito/gameMaster.dart';
import 'package:ito/userInfo.dart';
import 'config.dart';

config _config;

// ignore: must_be_immutable, camel_case_types
class numberCheck extends StatefulWidget{
  numberCheck(this._itemUser,this._gameMaster);
  List<userInfo> _itemUser;
  gameMaster _gameMaster;

  @override
  State<StatefulWidget> createState() => _numberCheckState();
}

// ignore: camel_case_types
class _numberCheckState extends State<numberCheck> {
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
            SizedBox(height: _config.deviceHeight * 0.04,),
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
                    return widget._itemUser[index].returnUserNumberWidget(_config,context);
                  },
                  itemCount: widget._itemUser.length,
                ),
              ),
            ),
            SizedBox(height: _config.deviceHeight * 0.04,),
            SizedBox(
              width: _config.deviceWidth * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('BACK'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}