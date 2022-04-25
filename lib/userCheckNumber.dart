import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ito/userInfo.dart';
import 'package:ito/openKeyword.dart';
import 'dart:math' as math;

// ユーザ追加画面と次の問題に移行する時に呼ばれるコンストラクタ
// ignore: camel_case_types, must_be_immutable
class userCheckNumber extends StatefulWidget{
  userCheckNumber(this._itemUser,this.orderNo);
  List<userInfo> _itemUser;
  int orderNo; // 何回目の番号チェックかを表す変数 (0からスタート)

  @override
  State<StatefulWidget> createState() => _userCheckNumberState();
}

// ignore: camel_case_types
class _userCheckNumberState extends State<userCheckNumber>  {

  @override
  void initState() {
    // 初回のみ各ユーザの数値とカードのパスを渡す
    if(widget.orderNo == 0){
      super.initState();
      widget._itemUser.forEach((element) {
        // 1~100までの数字を格納
        element.cardNo = math.Random().nextInt(100)+1;
        // 割り当てた数字を元にカードのパスを指定
        element.cardURL = userInfo.returnCardNumPath(element.cardNo);
        print(element.cardNo);
      });
    }
    tapFlag = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              //_itemUser[orderNo].userName.toString(),
              widget._itemUser[widget.orderNo].userName,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey
              ),
            ),
            returnCard(widget._itemUser[widget.orderNo].cardURL),
            // TODO : 各ページの履歴を消す
            if(widget.orderNo + 1 == widget._itemUser.length)
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO : お題の画面へ(push)
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => openKeyword(widget._itemUser)
                        )
                    );
                  },
                  child: Text('OPEN QUESTION'),
                ),
              )
            else
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => userCheckNumber(widget._itemUser,widget.orderNo + 1)
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