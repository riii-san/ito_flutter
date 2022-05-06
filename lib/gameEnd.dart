import 'package:flutter/material.dart';
import 'config.dart';
import 'mainForm.dart';

// ignore: camel_case_types
class gameEnd extends StatelessWidget{

  bool gameEndFlg;
  gameEnd(this.gameEndFlg);

  @override
  Widget build(BuildContext context) {
    config _config = new config(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            if(gameEndFlg)
              Text("GAME CLEAR")
            else
              Text("GAME END"),

            SizedBox(height: _config.deviceWidth * 0.1,),
            SizedBox(
              width: _config.deviceWidth * 0.5,
              child: ElevatedButton(onPressed: (){
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => mainForm()),
                        (_) => false);
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