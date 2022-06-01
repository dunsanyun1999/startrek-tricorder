//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_camera_demo/homepage.dart';
import 'package:path/path.dart';
import '../main.dart';
import 'package:sqflite/sqflite.dart';

class myLogs extends StatefulWidget {
  @override
  //const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;
  @override
  State<myLogs> createState() => _MyLogsState();
}


//TODO, acces all logs and print
//valid = DateTime.now - Duration 30 days
//change to format str
//SELECT * FROM LOGS WHERE time > valid

class Reading {
  final int id;
  final String type;
  final int reading;
  final String date;

  const Reading({
    required this.id,
    required this.type,
    required this.reading,
    required this.date
  });
}


// List<int> ids = <int>[];
// List<String> types = <String>[];
// List<int> bpm = <int>[];
// List<String> dates = <String>[];


class _MyLogsState extends State<myLogs> {
  List<Reading> readings = <Reading>[];
  List<int> ids = List<int>.filled(30,-1);
  List<String> types = List<String>.filled(30,"NULL");
  List<int> bpm = List<int>.filled(30,-1);
  List<String> dates = List<String>.filled(30,"NULL");

  // List<Reading> readings = List<Reading>.filled(30,
  //     Reading(id:-1, type: "NULL", reading: -1, date: "NULL"));

  void get_log() async {
    // ids.clear();
    // types.clear();
    // bpm.clear();
    // dates.clear();
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'tricorder.db');
    Database database = await openDatabase(path);
    var log = await database.rawQuery('SELECT * FROM logs');
    for (var i = 0; i < log.length; i++){
        //print(log[i]);
        ids[i] = int.parse(log[i]["id"].toString());
        types[i] = log[i]['type'].toString();
        bpm[i] = int.parse(log[i]["reading"].toString());
        dates[i] = log[i]["date"].toString();
    }
    //print(log.length);
    // print(int.parse(log[10]["reading"].toString()));
    //print(log[1]);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    const header_style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    const data_style = TextStyle(fontSize: 18);
    const bpm_style = TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold);
    Widget track_star = Icon(Icons.directions_run, size: 15);
    get_log();
    List<Widget> widget_list = <Widget>[];
    widget_list.add(
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("ID", style: header_style),
              Text("TYPE", style: header_style),
              Text("READING", style: header_style),
              Text("DATE/TIME", style: header_style)
            ]
        )
    );
    widget_list.add(
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [track_star, track_star, track_star, track_star, track_star,
            track_star, track_star, track_star]
        )
    );
    widget_list.add(
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text(" ", style: TextStyle(fontSize: 30))]
        )
    );

    for (int i = 0; i<ids.length; i++){
      if (ids[i] == -1){
      }else {
        if(types[i] == "Resting Heart Rate"){
          types[i] = "Resting";
        }else if (types[i] == "Active Heart Rate"){
          types[i] = "Active";
        }
        widget_list.add(
            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(ids[i].toString(), style: data_style),
                  Text(types[i], style: data_style),
                  Text(bpm[i].toString(), style: bpm_style),
                  Text(dates[i], style: data_style)
                ]
            )
        );
      }
    }

    void drop_table() async{
      Route route = MaterialPageRoute(builder: (context)=>myLogs());

      var databasePath = await getDatabasesPath();
      String path = join(databasePath, 'tricorder.db');
      Database database = await openDatabase(path);
      await database.execute('DELETE FROM logs');
      database.close();

      Navigator.pushReplacement(context, route);
      //setState(() {});
    }

    return MaterialApp(home: Scaffold(
        appBar: AppBar(
          title: Text("My Logs"),
          backgroundColor: Colors.grey,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.close), onPressed: () =>
            {
              Navigator.pop(context)
            }),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("---- History ----"),
            SizedBox(
              height: 400,
              child:ListView(
                padding: const EdgeInsets.all(1),
                children: widget_list,
              )
            ),
            IconButton(icon: const Icon(Icons.restart_alt), iconSize: 70.0,
            color: Colors.red, onPressed: () => {
                  drop_table(),
                  //setState(() {})
                })
          ]
        )


        // body: Text(ids[1].toString() + "\t" +
        //     types[1] + "\t" +
        //     bpm[1].toString() + "\t" +
        //     dates[1])

    ));
  }


}
