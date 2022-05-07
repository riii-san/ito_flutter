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
  // 正当数
  int success = 0;
  // 問題文番号が格納されているリスト(最大要素数は5)
  // TODO : 問題文が格納されているクラスを作成
  // TODO : 問題文番号をListに格納
  List<int> questionSentenceList = <int>[];
  // ユーザの順番通りに格納する結果リスト
  List<userInfo> resultUserList = <userInfo>[];
  // 現在の回答順の番号をもつ変数
  int currentOrderNo = 1;

  gameMaster(
      this.orderNo,
      this.questionNo,
      this.life
      );

  List<String> question = [
    '人気な漫画',
    '人気なゲーム',
    '人生で大切なこと・もの',
    '強そうな言葉',
    '強そうな効果音',
    'カッコいい苗字',
    'カッコいい名前',
    '生き物の強さ',
    'なりたい職業',
    '言われて嬉しい言葉',
    '時代遅れの言葉',
    '人気なコンビニ商品',
    '人気な100円ショップの商品',
    '歴史上の人物の強さ',
    'なりたい生き物',
    '楽しいこと',
    '嬉しいこと',
    '人気な食べ物',
    '雪山で遭難した時に持っていたいもの',
    '人気な飲み物',
    '人気な居酒屋メニュー'
  ];

}

