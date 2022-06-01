import 'package:flutter/material.dart';
import 'trashbin/new_user.dart';
import 'ui/edit_curr_user.dart';
import 'ui/my_logs.dart';
import 'ui/b_exercises.dart';
import 'ui/brmonitor.dart';
import 'ui/h_reader.dart';
import 'ui/active_h_reader.dart';
import 'profile_edit/name.dart';
import 'ui/test.dart';
import '../main.dart';
import 'profile_edit/profile.dart';
//Figure out dropdown menu of current users


class MyHomePage extends StatefulWidget {
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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      appBar: AppBar(
        title: const Text("Star Trek Tricorder"),
        backgroundColor: Colors.blueAccent,
        actions:<Widget>[
          IconButton(icon:const Icon(Icons.settings_rounded), onPressed: () =>{
            Navigator.push(context, MaterialPageRoute(builder:
                (context)=> editUser_Name()),)
          }),
          IconButton(icon:const Icon(Icons.person), onPressed: ()=>{
            Navigator.push(context, MaterialPageRoute(builder:
                (context) => Profile_check(),))
          }),
        ],
      ),
      body:Center(
        child: MyStatefulWidget()
      )
      )
    );
     }
}



//Our Buttons and Labels in the middle, used because centre can only have 1 child
class MyStatefulWidget extends StatefulWidget {

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

//Design of Buttons and Labels Below for direction
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(icon: const Icon(Icons.favorite), iconSize: 100.0, color: Colors.red,
                  onPressed : ()=>{
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> hReader()),),
                    is_active = false
                }
              ),
              const Text('Resting Heart Rate'),
              IconButton(icon: const Icon(Icons.run_circle), iconSize: 100.0, color: Colors.deepOrange, onPressed : () => {
                Navigator.push(context, MaterialPageRoute(builder:(context)=> hReader()),),
                is_active = true
              }),
              const Text('Active Heart Rate'),
              /*IconButton(icon: const Icon(Icons.circle), iconSize: 100.0, color: Colors.lightBlue, onPressed : () => {
                Navigator.push(context, MaterialPageRoute(builder:(context)=> brMonitor()),)
              }),
              const Text('Breathing Rate'),*/
              IconButton(icon: const Icon(Icons.storage_rounded), iconSize: 100.0, color: Colors.blueGrey, onPressed : () => {
                Navigator.push(context, MaterialPageRoute(builder:(context)=> myLogs()),)
              }),
              const Text('My Logs'),
            ]
        );
  }
}

