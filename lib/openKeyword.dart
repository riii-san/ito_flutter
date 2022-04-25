import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ito/userInfo.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// ignore: must_be_immutable, camel_case_types
class openKeyword extends StatefulWidget{
  openKeyword(this._itemUser);
  List<userInfo> _itemUser;

  @override
  State<StatefulWidget> createState() => _openKeywordState();
}

// ignore: camel_case_types
class _openKeywordState extends State<openKeyword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Question No.1',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.topLeft,
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                      'ここに問題が表示されますaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                      speed: const Duration(milliseconds: 100)
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
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