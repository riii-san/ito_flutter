import 'package:flutter/material.dart';

import 'gameStartPage.dart';

// ignore: camel_case_types
class mainForm extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/ito.png'),
            SizedBox(height: 60,),
            SizedBox(
              width: 200,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => gameStartPage()
                ));
              },
                child: Text(
                    'GAME START'
                ),
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              width: 200,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  // TODO : Tutorialページへ
                  //builder: (context) => gameStartPage()
                ));
              },
                child: Text(
                    'TUTORIAL'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}