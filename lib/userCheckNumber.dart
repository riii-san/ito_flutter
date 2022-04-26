import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ito/userInfo.dart';
import 'package:ito/gameMaster.dart';
import 'package:ito/openKeyword.dart';
import 'config.dart';
import 'dart:math' as math;

config _config;

// ユーザ追加画面と次の問題に移行する時に呼ばれるコンストラクタ
// ignore: camel_case_types, must_be_immutable
class userCheckNumber extends StatefulWidget{
  userCheckNumber(this._itemUser,this._gameMaster);
  List<userInfo> _itemUser;
  gameMaster _gameMaster;

  @override
  State<StatefulWidget> createState() => _userCheckNumberState();
}

// ignore: camel_case_types
class _userCheckNumberState extends State<userCheckNumber>  {

  @override
  void initState() {

    int tempNum;
    bool dupFlg = false;
    List<int> _userNoList = <int>[];

    // 初回のみ各ユーザの数値とカードのパスを渡す
    if(widget._gameMaster.orderNo == 0){
      super.initState();

      widget._itemUser.forEach((element) {
        // 1~100までの数字を格納
        // 重複の場合は再度番号発行
        while(!dupFlg){
          tempNum = math.Random().nextInt(100)+1;
          // 重複がない場合リストに追加
          if(!_userNoList.contains(tempNum)){
            _userNoList.add(tempNum);
            dupFlg = true;
          }
        }
        // 重複しない数字を指定
        element.cardNo = tempNum;
        // 割り当てた数字を元にカードのパスを指定
        element.cardURL = userInfo.returnCardNumPath(element.cardNo);
        // 重複フラグクリア
        dupFlg = false;
      });
    }
    // カードタップフラグクリア
    tapFlag = true;
  }

  @override
  Widget build(BuildContext context) {
    _config = new config(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: _config.deviceHeight * 0.1,
              child: Text(
                //_itemUser[orderNo].userName.toString(),
                widget._itemUser[widget._gameMaster.orderNo].userName,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey
                ),
              ),
            ),
            returnCard(widget._itemUser[widget._gameMaster.orderNo].cardURL),
            if(widget._gameMaster.orderNo + 1 == widget._itemUser.length)
              SizedBox(
                width: _config.deviceWidth * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    widget._gameMaster.orderNo = 0;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => openKeyword(widget._itemUser,widget._gameMaster)
                        )
                    );
                  },
                  child: Text('OPEN QUESTION'),
                ),
              )
            else
              SizedBox(
                width: _config.deviceWidth * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    widget._gameMaster.orderNo += 1;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => userCheckNumber(widget._itemUser,widget._gameMaster)
                        )
                    );
                  },
                  child: Text('NEXT USER'),
                ),
              ),
          ],
        )
      ),
    );
  }
}

bool tapFlag = true;

Widget returnCard(String cardURL){
  return AnimationCard(
    Image.asset(
      cardURL,
    ),
  );
}

class AnimationCard extends StatefulWidget {
  final Image frontImage;
  AnimationCard(this.frontImage) : super();
  _AnimationCardState createState() => _AnimationCardState();
}

class _AnimationCardState extends State<AnimationCard> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _frontAnination;
  Animation<double> _backAnination;

  Image _backImage = Image.asset("images/card_back.png");

  @override
  void initState() {

    super.initState();

    /*
     * アニメーションコントローラ
     */
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
    );

    /*
     * トランプの表アニメーション
     */
    _frontAnination = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    );

    /*
     * トランプの裏アニメーション
     */
    _backAnination = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: _config.deviceHeight * 0.5,

      child: GestureDetector(
        /*
         * トランプタッチジェスチャー
         */
        onTap: (){
          if(tapFlag){
            setState(() {
              if (_controller.isCompleted || _controller.velocity > 0)
                _controller.reverse();
              else
                _controller.forward();
            });
            tapFlag = false;
          }
        },

        child: Stack(
          children: <Widget>[
            /*
             * トランプ表
             */
            AnimatedBuilder(
              child: widget.frontImage,
              animation: _backAnination,
              builder: (BuildContext context, Widget child) {

                return _getCardTransform(
                  child,
                  _backAnination.value,
                );
              },
            ),

            /*
             * トランプ裏
             */
            AnimatedBuilder(
              child: _backImage,
              animation: _frontAnination,
              builder: (BuildContext context, Widget child) {

                return _getCardTransform(
                  child,
                  _frontAnination.value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Transform _getCardTransform(Widget child, dynamic value) {

    final Matrix4 transform = Matrix4.identity()
      ..scale(value, 1.0, 1.0);

    return Transform(
      transform: transform,
      alignment: FractionalOffset.center,
      child: child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}