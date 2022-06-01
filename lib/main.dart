import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:camera/camera.dart';
import 'package:torch_light/torch_light.dart';
import 'trashbin/new_user.dart';
import 'dart:io';
import 'package:image/image.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


List<CameraDescription> cameras = [];
var is_active = false;

Future<void> main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
    var databasePath = await getDatabasesPath();
    String path = join(databasePath,'tricorder.db');
    Database database = await openDatabase(path, version:1);
    database.execute(
        'CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, is_male boolean)'
      );
    database.execute(
      'CREATE TABLE IF NOT EXISTS logs (id INTEGER PRIMARY KEY, type TEXT, reading INT, date String)'
          //type, AHR = Active Heart Rate , RHR = Resting Heart rate
    );
    var result = await database.rawQuery('SELECT * FROM USER');
    print(result);
    await database.close();
    cameras = await availableCameras();
  } on CameraException catch (e){
    print('Error in fetching the cameras: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final"
