import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class gameMaster{

  // 初期値入れておく
  int orderNo = 0;
  int questionNo = 1;
  int life = 3;

  gameMaster(
      this.orderNo,
      this.questionNo,
      this.life
      );

}