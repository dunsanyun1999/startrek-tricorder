import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/profile_edit/review.dart';
import '/profile_edit/gender.dart';

class editUser_Name extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NameState();
}

class NameState extends State<editUser_Name>{

  final _text = TextEditingController();
  bool _validate = false;

  String name = "";

  @override
  void dispose(){
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[],
        ),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  // Text("",
                  //   style: TextStyle(color: Colors.blue, fontSize: 20),),
                  // SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Container(
                        width: 200,
                        child:
                        TextField(
                          controller: _text,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20
                          ),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            errorText: _validate? "Try Again" : null,
                            border: OutlineInputBorder(),),
                    ))
                  ]
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 175,
                  height: 80,
                  child:
                      ElevatedButton(
                        child: Text('Next',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onPressed: () {
                          setState((){
                            if(_text.text.isEmpty){
                              _validate = true;
                            }else {
                              _validate = false;
                              name = _text.text;
                              Route route = MaterialPageRoute(builder: (context) =>
                                  editUser_Gender(name: name));
                              Navigator.pushReplacement(context, route);
                            }
                          });
                        },
                      )
                )
                ]
            )
        ),
    );
  }

}