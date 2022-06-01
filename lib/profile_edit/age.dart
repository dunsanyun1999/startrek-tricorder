import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/profile_edit/review.dart';
import '/profile_edit/age.dart';

class editUser_Age extends StatefulWidget {
  final String name;
  final bool is_male;
  editUser_Age({required this.name, required this.is_male});
  @override
  State<StatefulWidget> createState(){
    return AgeState(name: name, is_male: is_male);
  }
}

class AgeState extends State<editUser_Age>{
  final String name;
  final bool is_male;
  AgeState({required this.name, required this.is_male});

  final _text = TextEditingController();
  bool _validate = false;

  int age = 0;

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
                        width: 100,
                        child:
                        TextField(
                          controller: _text,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40
                          ),
                          decoration: InputDecoration(
                            labelText: 'Age',
                            errorText: _validate? "Try Again" : null,
                            border: OutlineInputBorder(),),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly],
                          ),
                    ),
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
                            if (_text.text.isEmpty){
                              _validate = true;
                            }else{
                              age = int.parse(_text.text);
                              Route route = MaterialPageRoute(builder: (context) =>
                                  Review(name: name, is_male: is_male, age: age));
                              Navigator.pushReplacement(context, route);
                              _validate = false;
                            }
                            //print(int.parse(_text.text));
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