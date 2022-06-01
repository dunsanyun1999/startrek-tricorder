import 'package:flutter/material.dart';
import '/profile_edit/name.dart';
import '/profile_edit/age.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../main.dart';

class Profile_check extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Profile_checkState();
}
String name = "";
String age = "";
String gender = "";

class Profile_checkState extends State<Profile_check>{

  @override
  Widget build(BuildContext context) {
    // String name = "";
    // String age = "";
    // String gender = "";
    double font_size = 30;

    void getProfile() async {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, 'tricorder.db');
      Database database = await openDatabase(path);
      var result = await database.rawQuery('SELECT * FROM USER');
      //print(result);
      name = result[0]["name"].toString();
      age = result[0]["age"].toString();
      if (result[0]["is_male"].toString() == "1"){
        gender = "Male";
      }else{
        gender = "Female";
      }
      // List<String> results = [name, age, gender];
      // return results;
      //print(name + age + gender);
      setState(() {});
    }
    //print(name + age + gender);
    // Future<List<String>> result = getProfile();
    // name = result[0];
    getProfile();

    Route route = MaterialPageRoute(builder: (context)=> editUser_Name());
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[],
      ),
      body: SafeArea(
          child: Center( child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                RichText(text: TextSpan(
                    style: const TextStyle(fontSize:90, color: Colors.black,),
                    children:<TextSpan>[
                      TextSpan(text: "Profile",
                          style: const TextStyle(fontSize:30)),
                    ]
                )),
                SizedBox(
                    height: 50
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Name:",style: TextStyle(fontSize:font_size),),
                      SizedBox(width: 20),
                      Text(name,style: TextStyle(fontSize:font_size),)
                    ]
                  ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Gender:",style: TextStyle(fontSize:font_size),),
                      SizedBox(width: 20),
                      Text(gender,style: TextStyle(fontSize:font_size),)
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Age:",style: TextStyle(fontSize:font_size),),
                      SizedBox(width: 20),
                      Text(age,style: TextStyle(fontSize:font_size),)
                    ]
                ),
                SizedBox(
                    height: 50
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    IconButton(icon: const Icon(Icons.arrow_back_rounded), iconSize: 75.0, color: Colors.black, onPressed : () => {
                      Navigator.pop(context)
                    }),
                    IconButton(icon: const Icon(Icons.edit), iconSize: 75.0, color: Colors.grey, onPressed : () => {
                      Navigator.pushReplacement(context,route)
                    })
                  ]
                )
              ]
          ))
      ),
    );
  }
}