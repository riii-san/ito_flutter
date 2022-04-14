import 'package:flutter/material.dart';

// ignore: camel_case_types
class gameStartPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 250,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'add user',
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle, size: 25,),
                    color: Colors.blue,
                    onPressed: () {
                      // add user
                    })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    },
                      child: Text(
                          'CANCEL'
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black12
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    },
                      child: Text(
                          'START'
                      ),
                    ),
                  ),
                ],
              )

            ]
          ),
        )
    );
  }
}