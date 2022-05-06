import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ito/gameEnd.dart';
import 'package:ito/gameMaster.dart';
import 'package:ito/userAnswer.dart';
import 'package:ito/userCheckNumber.dart';
import 'package:ito/userInfo.dart';
import 'package:ito/answerCurrentQuestion.dart';
import 'config.dart';
import 'dart:async';

config _config;

// 今回の各ユーザの回答を判定するフラグ
bool currentJudgeFlg = false;
// カードがタップされたかどうかを判定するフラグ
bool tapFlg2;
// 丸orバツを描くかどうかを判定するフラグ
bool drawFlg = false;
// 次の画面へ進んでも良いかどうかを判定するフラグ
bool nextPageFlg;

// ignore: must_be_immutable, camel_case_types
class checkAnswer extends StatefulWidget{
  checkAnswer(this._itemUser,this._user,this._gameMaster);
  List<userInfo> _itemUser;
  userInfo _user;
  gameMaster _gameMaster;

  @override
  State<StatefulWidget> createState() => _checkAnswerState();
}

// ignore: camel_case_types
class _checkAnswerState extends State<checkAnswer> {

  @override
  void initState() {

    // tapFlg2 : カードを一回だけ反転可能にするフラグをON
    // nextPageFlg : 次の画面に遷移可能にするフラグをON
    tapFlg2 = true;
    nextPageFlg = false;

    // 画面が描画されるタイミングでカレントの判定を行う
    if(widget._gameMaster.resultUserList[widget._gameMaster.currentOrderNo-1].cardNo == widget._user.cardNo){
      currentJudgeFlg = true;
    }
    else{
      currentJudgeFlg = false;
    }
  }

  void redraw(){
    setState(() {});
  }

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
            // ↓ここからユーザ名とカードを表示
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    if(widget._gameMaster.currentOrderNo == 1)
                      Text(widget._user.userName)
                    else
                      Text(widget._gameMaster.resultUserList[0].userName),
                    if(widget._gameMaster.currentOrderNo == 1)
                      returnCard(widget._user.cardURL,redraw)
                    else
                      returnNumCard(widget._gameMaster.resultUserList[0].cardURL)
                  ],
                ),
                Column(
                  children: <Widget>[
                    if(widget._gameMaster.currentOrderNo < 2)
                      Text("")
                    else if(widget._gameMaster.currentOrderNo == 2)
                      Text(widget._user.userName)
                    else
                      Text(widget._gameMaster.resultUserList[1].userName),
                    if(widget._gameMaster.currentOrderNo == 2)
                      returnCard(widget._user.cardURL,redraw)
                    else if(widget._gameMaster.currentOrderNo < 2)
                      returnNoneCard(userInfo.returnNoneCardPath())
                    else
                      returnNumCard(widget._gameMaster.resultUserList[1].cardURL)
                  ],
                ),
                Column(
                  children: <Widget>[
                    if(widget._gameMaster.currentOrderNo < 3)
                      Text("")
                    else if(widget._gameMaster.currentOrderNo == 3)
                      Text(widget._user.userName)
                    else
                      Text(widget._gameMaster.resultUserList[2].userName),
                    if(widget._gameMaster.currentOrderNo == 3)
                      returnCard(widget._user.cardURL,redraw)
                    else if(widget._gameMaster.currentOrderNo < 3)
                      returnNoneCard(userInfo.returnNoneCardPath())
                    else
                      returnNumCard(widget._gameMaster.resultUserList[2].cardURL)
                  ]
                ),
              ],
            ),
            SizedBox(height: _config.deviceHeight * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.currentOrderNo < 4)
                        Text("")
                      else if(widget._gameMaster.currentOrderNo == 4)
                        Text(widget._user.userName)
                      else
                        Text(widget._gameMaster.resultUserList[3].userName),
                      if(widget._gameMaster.currentOrderNo == 4)
                        returnCard(widget._user.cardURL,redraw)
                      else if(widget._gameMaster.currentOrderNo < 4)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[3].cardURL)
                    ]
                ),
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.currentOrderNo < 5)
                        Text("")
                      else if(widget._gameMaster.currentOrderNo == 5)
                        Text(widget._user.userName)
                      else
                        Text(widget._gameMaster.resultUserList[4].userName),
                      if(widget._gameMaster.currentOrderNo == 5)
                        returnCard(widget._user.cardURL,redraw)
                      else if(widget._gameMaster.currentOrderNo < 5)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[4].cardURL)
                    ]
                ),
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.currentOrderNo < 6)
                        Text("")
                      else if(widget._gameMaster.currentOrderNo == 6)
                        Text(widget._user.userName)
                      else
                        Text(widget._gameMaster.resultUserList[5].userName),
                      if(widget._gameMaster.currentOrderNo == 6)
                        returnCard(widget._user.cardURL,redraw)
                      else if(widget._gameMaster.currentOrderNo < 6)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[5].cardURL)
                    ]
                ),
              ],
            ),
            SizedBox(height: _config.deviceHeight * 0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.currentOrderNo < 7)
                        Text("")
                      else if(widget._gameMaster.currentOrderNo == 7)
                        Text(widget._user.userName)
                      else
                        Text(widget._gameMaster.resultUserList[6].userName),
                      if(widget._gameMaster.currentOrderNo == 7)
                        returnCard(widget._user.cardURL,redraw)
                      else if(widget._gameMaster.currentOrderNo < 7)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[6].cardURL)
                    ]
                ),
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.currentOrderNo < 8)
                        Text("")
                      else if(widget._gameMaster.currentOrderNo == 8)
                        Text(widget._user.userName)
                      else
                        Text(widget._gameMaster.resultUserList[7].userName),
                      if(widget._gameMaster.currentOrderNo == 8)
                        returnCard(widget._user.cardURL,redraw)
                      else if(widget._gameMaster.currentOrderNo < 8)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[7].cardURL)
                    ]
                ),
                Column(
                    children: <Widget>[
                      if(widget._gameMaster.currentOrderNo < 9)
                        Text("")
                      else if(widget._gameMaster.currentOrderNo == 9)
                        Text(widget._user.userName)
                      else
                        Text(widget._gameMaster.resultUserList[8].userName),
                      if(widget._gameMaster.currentOrderNo == 9)
                        returnCard(widget._user.cardURL,redraw)
                      else if(widget._gameMaster.currentOrderNo < 9)
                        returnNoneCard(userInfo.returnNoneCardPath())
                      else
                        returnNumCard(widget._gameMaster.resultUserList[8].cardURL)
                    ]
                ),
              ],
            ),
            SizedBox(height: _config.deviceHeight * 0.03,),
            // 次の画面の移行条件
            // ①正解且つまだ回答していないユーザがいれば回答画面へ
            // ②正解且つ全てのユーザの回答が終了し、まだ問題を3つクリアしていなければ次の問題へ(ユーザカード確認画面へ)
            // ③正解且つ全てのユーザの回答が終了し、3つの問題をクリアしていればゲームクリア画面へ
            // ④間違えた場合、今回の問題の答え合わせ画面へ

            // ④
            // なぜか入らなかったため、一番最初に記述
            if(currentJudgeFlg == false && nextPageFlg)
              SizedBox(
              width: _config.deviceWidth * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  // orderNo:初期化(0) , questionNo:+1 , life:-1 , resultUserList:初期化(要素削除) , currentOrderNo:初期化(1) , _itemUserのdecidedStatus:初期化
                  widget._gameMaster.orderNo = 0;
                  widget._gameMaster.life--;
                  widget._gameMaster.currentOrderNo = 1;
                  widget._itemUser = userInfo.returnInitializeUserDecidedStatusList(widget._itemUser);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => answerCurrentQuestion(widget._itemUser,widget._gameMaster),
                  )
                  );
                },
                child: Text('CHECK ANSWER'),
              ),
            )
            // ①
            else if(currentJudgeFlg && nextPageFlg && widget._gameMaster.currentOrderNo < widget._gameMaster.resultUserList.length)
              SizedBox(
                width: _config.deviceWidth * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    // オーダー番号をインクリメントする
                    widget._gameMaster.currentOrderNo++;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => userAnswer(widget._itemUser,widget._gameMaster),
                    )
                    );
                  },
                  child: Text('NEXT USER ANSWER'),
                ),
              )
            // ②,③
            else if(currentJudgeFlg && nextPageFlg && widget._gameMaster.currentOrderNo == widget._gameMaster.resultUserList.length)
              // ②
              if(widget._gameMaster.success < 2)
                SizedBox(
                  width: _config.deviceWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      // 次の問題画面へ
                      // 次の問題に行く前に下記項目の値を変更
                      // orderNo:初期化(0) , questionNo:+1 , success:+1 , resultUserList:初期化(要素削除) , currentOrderNo:初期化(1) , _itemUserのdecidedStatus:初期化
                      widget._gameMaster.orderNo = 0;
                      widget._gameMaster.questionNo++;
                      widget._gameMaster.success++;
                      widget._gameMaster.resultUserList.clear();
                      widget._gameMaster.currentOrderNo = 1;
                      widget._itemUser = userInfo.returnInitializeUserDecidedStatusList(widget._itemUser);
                      Navigator.push(context, MaterialPageRoute(
                        // ユーザカード確認画面へ
                        builder: (context) => userCheckNumber(widget._itemUser,widget._gameMaster),
                      )
                      );
                    },
                    child: Text('NEXT QUESTION'),
                  ),
                )
              // ③
              else if(widget._gameMaster.success == 2)
                SizedBox(
                  width: _config.deviceWidth * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => gameEnd(true),
                      )
                      );
                    },
                    child: Text('END'),
                  ),
                )
          ],
        ),
      ),
    );
  }
}


Widget returnNoneCard(String cardURL){
  return Image.asset(cardURL,height: _config.deviceHeight * 0.18,);
}

Widget returnNumCard(String cardURL){
  return Image.asset(cardURL,height: _config.deviceHeight * 0.18,);
}

Widget returnCard(String cardURL,var recieveRedraw){
  return AnimationCard(
    Image.asset(
      cardURL,
    ),
    recieveRedraw
  );
}

class AnimationCard extends StatefulWidget {
  final Image frontImage;
  var receiveRedraw;
  AnimationCard(this.frontImage,this.receiveRedraw) : super();
  _AnimationCardState createState() => _AnimationCardState();
}

class _AnimationCardState extends State<AnimationCard> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _frontAnination;
  Animation<double> _backAnination;

  Image _backImage = Image.asset("images/card_back.png");

  void drawIcon(){
    drawFlg = true;
    setState(() {});
    Duration threeSeconds = Duration(seconds: 3);
    Future.delayed(threeSeconds, () {
      drawFlg = false;
      nextPageFlg = true;
      setState(() {});
      // 親Widgetの一番下のボタンを表示させるために画面更新
      widget.receiveRedraw();
    });
  }

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
          if(tapFlg2){
            setState(() {
              if (_controller.isCompleted || _controller.velocity > 0)
                _controller.reverse();
              else
                _controller.forward();
            });
            tapFlg2 = false;

            // 非同期で判定アイコン表示
            Duration threeSeconds = Duration(seconds: 3);
            Future.delayed(threeSeconds, () {
              drawIcon();
            });
          }
        },

        child: Stack(
          alignment: AlignmentDirectional.center,
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
            // 正解であれば丸、間違いの場合バツ
            if(drawFlg && currentJudgeFlg)
              Container(
                  child: Icon(Icons.circle_outlined, size: _config.deviceWidth * 0.25, color: Colors.lightGreen,)
              )
            else if(drawFlg && !currentJudgeFlg)
              Container(
                  child: Icon(Icons.clear, size: _config.deviceWidth * 0.25, color: Colors.red,)
              )
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
