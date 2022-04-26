import 'package:flutter/cupertino.dart';

class config{

  // 画面サイズ定義
  double deviceHeight; // 縦 : 926.0
  double deviceWidth; // 横 : 428.0

  config(var context){
    this.deviceHeight = MediaQuery.of(context).size.height;
    this.deviceWidth = MediaQuery.of(context).size.width;
  }

}