import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class userInfo{

  int userId;
  final String userName;
  int cardNo;
  String cardURL;

  userInfo(
      this.userId,
      this.userName,
      this.cardNo,
      this.cardURL
      );

  Widget returnUserWidget(void Function(int,String) userRemove){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 270,
              height: 50,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)
              ),
              child: Text(
                  userName,
                  style: TextStyle(fontSize: 20)
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 25,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.grey
                    ),
                    onPressed: (){
                      userRemove(this.userId,this.userName);
                    },
                    child: Icon(Icons.cancel_rounded,color: Colors.white,)
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 5,)
      ],
    );
  }

  static String returnCardNumPath(int num){

    return 'images/' + num.toString() + '.png';

  }

}
