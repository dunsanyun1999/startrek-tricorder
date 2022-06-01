import 'package:flutter/material.dart';
import 'package:flutter_camera_demo/homepage.dart';

class brMonitor extends StatefulWidget {
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
  State<brMonitor> createState() => _BRMonitorState();
}

class _BRMonitorState extends State<brMonitor> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
        appBar: AppBar(
          title: Text("Breathing Rate Monitor"),
          backgroundColor: Colors.deepPurpleAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.close), onPressed: () =>
            {
              Navigator.pop(context)
            }),
          ],
        ),
        body: Center(
          child: BRstartWidget()
        )
    )
    );
  }
}



class BRstartWidget extends StatefulWidget {

  @override
  _bRateStartState createState() => _bRateStartState();
}

//Design of Buttons and Labels Below for direction
class _bRateStartState extends State<BRstartWidget> {
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Place your microphone near your face, and breathe for the displayed time', //to change of course
            style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
          IconButton(icon: Icon(Icons.circle), iconSize: 300.0, color: Colors.blueAccent, padding: EdgeInsets.all(20) ,  onPressed : ()=>{}
          ),
          Text('Begin', textAlign: TextAlign.center)

        ]
    );
  }
}


