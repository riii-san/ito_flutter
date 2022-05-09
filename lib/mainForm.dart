import 'package:flutter/material.dart';
import 'package:ito/tutorial.dart';
import 'config.dart';
import 'gameStartPage.dart';

// ignore: camel_case_types
class mainForm extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    config _config = new config(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/ito.png',
              width: _config.deviceWidth * 0.4,
            ),
            SizedBox(height: _config.deviceHeight * 0.1,),
            SizedBox(
              width: _config.deviceWidth * 0.5,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => gameStartPage()
                ));
              },
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                      'GAME START'
                  ),
                ),
              ),
            ),
            SizedBox(height: _config.deviceWidth * 0.1,),
            SizedBox(
              width: _config.deviceWidth * 0.5,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  // TODO : Tutorialページへ
                  // debug ゲームエンドページへ
                  builder: (context) => tutorial()
                ));
              },
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                      'TUTORIAL'
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}