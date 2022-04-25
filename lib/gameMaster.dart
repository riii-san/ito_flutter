import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class gameMaster{

  // ユーザが数字を確認する番号
  int orderNo;
  // 現在の問題番号
  int questionNo;
  // 残り体力
  int life;
  // 問題文番号が格納されているリスト(最大要素数は5)
  // TODO : 問題文が格納されているクラスを作成
  // TODO : 問題文番号をListに格納
  List<int> questionSentenceList;

  gameMaster(
      this.orderNo,
      this.questionNo,
      this.life
      );

}