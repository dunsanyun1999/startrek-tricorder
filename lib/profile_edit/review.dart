import 'package:flutter/material.dart';
import '/profile_edit/name.dart';
import '/profile_edit/age.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../main.dart';

class Review extends StatefulWidget {
  final String name;
  final bool is_male;
  final int age;

  Review({required this.name, required this.is_male, required this.age});
  @override
  State<StatefulWidget> createState(){
    return ReviewState(name:name, is_male:is_male, age:age);
  }
}

class ReviewState extends State<Review>{
  final String name;
  final bool is_male;
  final int age;
  ReviewState({required this.name, required this.is_male, required this.age});


  @override
  Widget build(BuildContext context) {
    // Route route_gender = MaterialPageRoute(builder: (context) =>
    //     editUser_Name());
    String gender = "";
    if(is_male){
      gender = "Male";
    } else {
      gender = "Female";
    }
    double font_size = 30;


    // TODO: implement database
    void in_db(String name, bool gender, int age) async {
      var databasePath = await getDatabasesPath();
      String path = join(databasePath, 'tricorder.db');
      Database database = await openDatabase(path);
      database.execute('DELETE FROM user');
      database.execute('INSERT INTO user(name, age, is_male) VALUES  (?,?,?)',
          [name, age, gender]
      );
      database.execute('DELETE FROM logs');
      // var result = await database.rawQuery('SELECT * FROM USER');
      // print(result);
      // print(result[0]["is_male"]);
      database.close();
      Navigator.pop(context);
    }
      //   WidgetsFlutterBinding.ensureInitialized();
    //   final database = openDatabase(
    //     join(await getDatabasesPath(), 'database.db'),
    //   );
    //   onCreate(db, version){
    //     return db.execute(
    //       'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
    //     );
    //   }
    //   version:1;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
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
                      TextSpan(text: "Review Profile",
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
                      Text(age.toString(),style: TextStyle(fontSize:font_size),)
                    ]
                ),
                SizedBox(
                    height: 50
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    IconButton(icon: const Icon(Icons.save), iconSize: 75.0, color: Colors.black, onPressed : () => {
                      in_db(name, is_male,age)
                    }),
                    IconButton(icon: const Icon(Icons.delete), iconSize: 75.0, color: Colors.grey, onPressed : () => {
                      Navigator.pop(context)
                    })
                  ]
                )
              ]
          ))
      ),
    );
  }
}