import 'package:flutter/material.dart';

// ignore: camel_case_types
class gameStartPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title : Text("ページ(1)")
        ),
        body : Center(
          child: TextButton(
            child: Text("メインフォームへ戻る"),
            // （1） 前の画面に戻る
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        )
    );
  }
}