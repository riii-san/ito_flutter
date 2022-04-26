import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'config.dart';

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

  Widget returnUserWidget(void Function(int,String) userRemove , config _config){
    return Column(
      children: <Widget>[
        Container(
          height: _config.deviceHeight * 0.055,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: _config.deviceWidth * 0.6,
                height: _config.deviceHeight * 0.055,
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
                  height: _config.deviceHeight * 0.03,
                  width: _config.deviceWidth * 0.05,
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
        ),
        SizedBox(height: _config.deviceHeight * 0.008,)
      ],
    );
  }

  static String returnCardNumPath(int num){

    return 'images/' + num.toString() + '.png';

  }

}
