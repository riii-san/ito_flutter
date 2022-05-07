import 'package:flutter/material.dart';
import 'config.dart';
import 'mainForm.dart';

// ignore: camel_case_types, must_be_immutable
class gameEnd extends StatelessWidget{

  bool gameEndFlg;
  gameEnd(this.gameEndFlg);

  @override
  Widget build(BuildContext context) {
    config _config = new config(context);
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: _config.deviceHeight * 0.45,),

            if(gameEndFlg)
              Text(
                "GAME CLEAR !!",
                style: TextStyle(color: Colors.grey,fontSize: 25),
              )
            else
              Text(
                "GAME OVER",
                style: TextStyle(color: Colors.grey,fontSize: 25),
              ),

            SizedBox(height: _config.deviceHeight * 0.3,),
            SizedBox(
              width: _config.deviceWidth * 0.5,
              child: ElevatedButton(onPressed: (){
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return mainForm();
                    },
                    transitionDuration: Duration(milliseconds: 1500),
                    reverseTransitionDuration: Duration(milliseconds: 1500),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      final color = ColorTween(
                        begin: Colors.transparent,
                        end: Colors.black, // ブラックアウト
                        // end: Colors.white, // ホワイトアウト
                      ).animate(CurvedAnimation(
                        parent: animation,
                        // 前半
                        curve: Interval(
                          0.0,
                          0.5,
                          curve: Curves.easeInOut,
                        ),
                      ));
                      final opacity = Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        // 後半
                        curve: Interval(
                          0.5,
                          1.0,
                          curve: Curves.easeInOut,
                        ),
                      ));
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Container(
                            color: color.value,
                            child: Opacity(
                              opacity: opacity.value,
                              child: child,
                            ),
                          );
                        },
                        child: child,
                      );
                    },
                  ),
                );
              },
                child: Text(
                    'HOME'
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}