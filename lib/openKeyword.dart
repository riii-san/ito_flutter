import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ito/gameStartPage.dart';

class openKeyword extends StatefulWidget{
  openKeyword(this._itemUser);
  List<userInfo> _itemUser;

  @override
  State<StatefulWidget> createState() => _openKeywordState();
}

// ignore: camel_case_types
class _openKeywordState extends State<openKeyword>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('戻る'),
              ),
            ),
          ],
        ),
      ),
    );
  }



}