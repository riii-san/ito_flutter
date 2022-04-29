import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ito/gameMaster.dart';
import 'package:ito/userInfo.dart';
import 'config.dart';

config _config;

// ignore: must_be_immutable, camel_case_types
class checkAnswer extends StatefulWidget{
  checkAnswer(this._itemUser,this._gameMaster);
  List<userInfo> _itemUser;
  gameMaster _gameMaster;

  @override
  State<StatefulWidget> createState() => _checkAnswerState();
}

// ignore: camel_case_types
class _checkAnswerState extends State<checkAnswer> {

  @override
  Widget build(BuildContext context) {
    _config = new config(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: _config.deviceHeight * 0.1,),
            Row(
              children: <Widget>[
                SizedBox(width: _config.deviceWidth * 0.03,),
                for(int i = 0; i < widget._gameMaster.life; i++)
                  Container(
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  )
              ],
            ),
            SizedBox(height: _config.deviceHeight * 0.01,),
            Container(
              alignment: Alignment.center,
              height: _config.deviceHeight * 0.1,
              child: Text(
                'Question No.' + widget._gameMaster.questionNo.toString(),
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey
                ),
              ),
            ),
            SizedBox(height: _config.deviceHeight * 0.01,),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    returnCard(widget._itemUser[0].cardURL),
                    returnCard(widget._itemUser[1].cardURL),
                    returnCard(widget._itemUser[2].cardURL),
                  ],
                ),
                SizedBox(height: _config.deviceHeight * 0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    returnCard(widget._itemUser[3].cardURL),
                    returnCard(widget._itemUser[3].cardURL),
                    returnCard(widget._itemUser[3].cardURL),
                  ],
                ),
                SizedBox(height: _config.deviceHeight * 0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    returnCard(widget._itemUser[3].cardURL),
                    returnCard(widget._itemUser[3].cardURL),
                    returnCard(widget._itemUser[3].cardURL),
                  ],
                )
              ],
            ),
            SizedBox(height: _config.deviceHeight * 0.05,),
            SizedBox(
              width: _config.deviceWidth * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('NEXT QUESTION'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
      height: _config.deviceHeight * 0.18,

      child: GestureDetector(
        /*
         * トランプタッチジェスチャー
         */
        onTap: () {
            setState(() {
              if (_controller.isCompleted || _controller.velocity > 0)
                _controller.reverse();
              else
                _controller.forward();
            });
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