import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_demo/homepage.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../ui/sensor_values.dart';
import 'package:camera/camera.dart';
import 'package:torch_light/torch_light.dart';
import 'package:image/image.dart' as img; //https://stackoverflow.com/questions/61216815/how-can-i-get-average-color-in-flutter
import '../main.dart';

import 'dart:async';
import 'dart:io';

class hrResults extends StatelessWidget {
  final double bpm;
  hrResults({required this.bpm});

  @override
  Widget build(BuildContext context) {
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
                    child: RichText(text: TextSpan(
                        style: const TextStyle(fontSize:30, color: Colors.black,),
                        children:<TextSpan>[
                          TextSpan(text: "Active Heart Rate",
                          )]
                    ))
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
                    color: Colors.deepOrange
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(62)
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                      IconButton(icon: const Icon(Icons.save), iconSize: 75.0, color: Colors.black, onPressed : () => {
                        //TODO
                      }),
                      IconButton(icon: const Icon(Icons.delete), iconSize: 75.0, color: Colors.grey, onPressed : () => {
                        Navigator.pop(context)
                      })
                    ])
              ]
          )
      ),
    );
  }

}