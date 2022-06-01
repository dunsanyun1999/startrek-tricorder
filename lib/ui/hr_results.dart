import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_demo/homepage.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../ui/sensor_values.dart';
import 'package:camera/camera.dart';
import 'package:torch_light/torch_light.dart';
import 'package:image/image.dart' as img; //https://stackoverflow.com/questions/61216815/how-can-i-get-average-color-in-flutter
import '../main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../feedback/feedback_helper.dart';
import 'dart:async';
import 'dart:io';

class hrResults extends StatefulWidget{
  final double bpm;
  hrResults({required this.bpm});
  @override
  State<StatefulWidget> createState() => hrResultsState(bpm:bpm);
}

class hrResultsState extends State<hrResults> {
  final double bpm;
  hrResultsState({required this.bpm});

  void log_data(int reading) async{
    DateTime now = DateTime.now();
    var currentTime = DateFormat('yyyy-MM-dd - kk:mm').format(now);
    var date = currentTime.toString();
    var type ="";
    if (!is_active) {
     type = "Resting Heart Rate";
    }else {
      type = "Active Heart Rate";
    }
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'tricorder.db');
    Database database = await openDatabase(path);
    database.execute('INSERT INTO logs(type, reading, date) VALUES (?,?,?)', [type,reading, date]);
    var result = await database.rawQuery('SELECT * FROM logs');
    print(result);
    database.close();
  }



  String name = "";
  String age = "";
  String gender = "";
  var text = "";
  var print_text = "";
  var smoke_text = "";
  bool smoke_warning = false;
  Color box_color = Colors.white;

  TextStyle text_style = const TextStyle(fontWeight: FontWeight.bold,fontSize:20,
      color: Colors.black,);

  TextStyle text_style_zone = const TextStyle(fontWeight: FontWeight.bold,
      fontSize:20, color: Colors.black);

  @override
  Widget build(BuildContext context) {
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
      if (is_active == false) {
        text = await restingFeedback(age, bpm, gender);
      }else if(is_active == true){
        text = await activeFeedback(age,bpm);
      }
      setState(() {});
    }
    // TODO: Display feedback

    getProfile();
    if (text == "Excellent"){
        print_text = "Your resting heart rate is Excellent!";
        box_color = Colors.green;
    }else if(text == "Good"){
      print_text = "Your resting heart rate is Good!";
      box_color = Colors.lightGreen;
    }else if(text == "Average"){
      print_text = "Your resting heart rate is Average!";
      box_color = Colors.yellow;
    }else if(text == "Below Average"){
      print_text = "Your resting heart rate is Below Average";
      smoke_warning = true;
      box_color = Colors.orange;
    }else if(text == "Poor"){
      print_text = "Your resting heart rate is Poor";
      smoke_warning = true;
      box_color = Colors.red;
    }else if(text == "1"){
      print_text = "You are in Cardiac Zone 1";
      box_color = Colors.green;
      text_style = text_style_zone;
    }else if(text == "2"){
      print_text = "You are in Cardiac Zone 2";
      box_color = Colors.lightGreen;
      text_style = text_style_zone;
    }else if(text == "3"){
      print_text = "You are in Cardiac Zone 3";
      box_color = Colors.yellow;
      text_style = text_style_zone;
    }else if(text == "4"){
      print_text = "You are in Cardiac Zone 4";
      box_color = Colors.orange;
      text_style = text_style_zone;
    }else if(text == "5"){
      print_text = "You are in Cardiac Zone 5";
      box_color = Colors.deepOrange;
      text_style = text_style_zone;
    }else if(text == "-1"){
      print_text = "Work harder! You are not in a Cardiac Zone!";
      box_color = Colors.lightBlue;
      text_style = text_style_zone;
    }else if(text == "-2"){
      print_text = "You are overworking! You are above your max heart rate!";
      box_color = Colors.red;
      text_style = text_style_zone;
    }

    if (smoke_warning){
      smoke_text = "Did you know that smoking can increase your heart rate by 30%?";
    }

    //print(text);

    int hb = bpm.toInt();
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          // IconButton(icon: Icon(Icons.arrow_back), onPressed: () =>
          // {
          //   Navigator.pop(context)
          // }),
        ],
      ),
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                Center(

                    child:Text(is_active ? "Active Heart Rate": "Resting Heart Rate",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                Container(
                    //color: Colors.redAccent,
                    child: Center(
                        child: RichText(text: TextSpan(
                            style: const TextStyle(fontSize:90, color: Colors.black,),
                            children:<TextSpan>[
                              TextSpan(text: hb.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold)
                              ),TextSpan(text: "bpm",
                                  style: const TextStyle(fontSize:30)),
                            ]
                        ))
                    ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: box_color
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(62)
                ),
                Container(
                  //color: Colors.redAccent,
                    child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                            text: TextSpan(
                        //style: const TextStyle(fontSize:30, color: Colors.black,),
                            children:<TextSpan>[
                                TextSpan(text: print_text,
                                        style: text_style,)
                              ]
                              )
                        )
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: box_color
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20)
                ),
                Text(smoke_text, style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      IconButton(icon: const Icon(Icons.save), iconSize: 75.0, color: Colors.black, onPressed : () => {
                        log_data(hb),
                        Navigator.pop(context)
                      }),
                      IconButton(icon: const Icon(Icons.delete), iconSize: 75.0, color: Colors.grey, onPressed : () => {
                        Navigator.pop(context)
                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>hrResults(bpm: 65)))
                      }),
                      // IconButton(icon: const Icon(Icons.restart_alt), iconSize: 75.0, color: Colors.grey, onPressed : () => {
                      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>hrResults(bpm: 1000)))
                      // })
                    ])
              ]
          )
      ),
    );
  }

}