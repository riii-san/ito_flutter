import 'package:flutter/material.dart';
import 'config.dart';
import 'mainForm.dart';

config _config;

// ignore: camel_case_types, must_be_immutable
class tutorial extends StatelessWidget{
  

  @override
  Widget build(BuildContext context) {
    config _config = new config(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[

              SizedBox(height: _config.deviceHeight * 0.05,),
              Container(
                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.black),
                  // ),
                  child: Image.asset('images/tutorial_1.jpeg')
              ),
              Container(
                  width: double.infinity,
                  /*
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                   */
                  child: Image.asset('images/tutorial_2.jpeg')
              ),
              Container(
                width: double.infinity,
                  /*
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                   */
                  child: Image.asset('images/tutorial_3.jpeg')
              ),
              Container(
                width: double.infinity,
                  /*
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),

                   */
                  child: Image.asset('images/tutorial_4.jpeg')
              ),
              SizedBox(height: _config.deviceHeight * 0.05,),
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
              SizedBox(height: _config.deviceHeight * 0.1,)
            ],
          ),
        ),
      ),
    );
  }
}