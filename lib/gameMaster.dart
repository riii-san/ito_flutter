import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ito/userInfo.dart';


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
  // ユーザの順番通りに格納する結果リスト
  List<userInfo> resultUserList = <userInfo>[];
  // 現在の回答順の番号をもつ変数
  int currentOrderNo = 1;

  gameMaster(
      this.orderNo,
      this.questionNo,
      this.life
      );

}

