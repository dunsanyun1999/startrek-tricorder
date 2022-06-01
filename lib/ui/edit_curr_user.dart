import 'package:flutter/material.dart';
import 'package:flutter_camera_demo/homepage.dart';

class editUser extends StatefulWidget {
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
  State<editUser> createState() => _EditUserState();
}

class _EditUserState extends State<editUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
        appBar: AppBar(
          title: Text("New User"),
          backgroundColor: Colors.deepOrangeAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.close), onPressed: () =>
            {
              Navigator.pop(context)
            }),
          ],
        ),
        body: Column(
        )
    )
    );
  }
}
