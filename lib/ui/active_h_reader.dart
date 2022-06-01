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

import '../trashbin/active_hr_results.dart';


//List<CameraDescription> cameras = [];

class active_hReader extends StatefulWidget {
  //final String title;
  @override
  State <active_hReader> createState() => _active_HreaderState();
}

class _active_HreaderState extends State<active_hReader> {
  CameraController? controller;
  bool _isCameraInitialized = false;


  double y_value = 0.0;
  double u_value = 0.0;
  double v_value = 0.0;

  //For calculating the acceptable reading range
  double max_ratio = 0.95;
  double min_ratio = 1.05;

  //Acceptable reading range
  double max_y = 0.0;
  double min_y = 10000.0;

  //Threshold: the imaginary line that you have to cross to count as a hb
  double threshold = 0.0;
  double temp_threshold = 0.0;


  //Blood density is below threshold (i.e. y value above threshold)
  bool hb = false;
  bool hb_previous = false;
  int hb_count = 0;
  double bpm = 0;

  bool torch = false;

  //phase ends at this time:
  Duration phase_length = Duration(seconds:5);
  var phase_end = new DateTime.now();
  int phase = 0; //for debugging

  Duration cali_length = Duration(seconds: 5);
  Duration full_measure_time = Duration(seconds: 15);

  var now = new DateTime.now();
  var cali_stop = new DateTime.now();
  var stop_time = new DateTime.now();
  var start_time = new DateTime.now();

  Duration time_passed = Duration(seconds: 0);
  double time_passed_m = 0.0;

  bool paused = false;
  DateTime start_pause = new DateTime.now();
  Duration temp_pause = Duration(seconds: 0);
  Duration time_paused = Duration(seconds: 0);

  //CHART STUFF:
  int chart_length = 25;
  int min_chart = 0;
  List<SensorValue> data = List<SensorValue>.filled(25,
      SensorValue(y:60,time:0,barColor: charts.Color.transparent));
  //final data = <SensorValue>[];



  //https://blog.logrocket.com/flutter-camera-plugin-deep-dive-with-examples/
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    //Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.low,
    );
    //Dispose previous controller
    await previousCameraController?.dispose();
    //Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }
    //Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    //Initialize controller
    try {
      await cameraController.initialize();
      await controller?.startImageStream((CameraImage image) => _scanImage(image));
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  _scanImage(CameraImage image){

    //img.Image? bytes = img.decodeImage(image)
    //https://stackoverflow.com/questions/57603146/how-to-convert-camera-image-to-image-in-flutter
    //https://softpixel.com/~cwright/programming/colorspace/yuv/

    y_value =
        image.planes[0].bytes.reduce((value, element) => value + element) /
            image.planes[0].bytes.length; //avg red value
    u_value =
        image.planes[1].bytes.reduce((value, element) => value + element) /
            image.planes[1].bytes.length; //avg red value
    v_value =
        image.planes[2].bytes.reduce((value, element) => value + element) /
            image.planes[2].bytes.length; //avg red value
    setState((){});
  }


  Future<void> _enableTorch() async {
      try {
        await controller?.setFlashMode(FlashMode.torch);
      } on Exception catch (_) {
        print("error");
      }
  }

  Future<void> _disableTorch() async {
    try {
      await controller?.setFlashMode(FlashMode.off);
    } on Exception catch (_) {
      print("error");
    }
  }

  Future<void> _calculateTimes() async{
    now = new DateTime.now();
    cali_stop = now.add(cali_length);
    stop_time = now.add(full_measure_time);
  }

  Future<void> _startRead2() async{
    double y_2 = 1.0;
    double y_1 = 2.0;
    double y = y_value;
    int i = 0;

    await Future.delayed(Duration(seconds: 2));
    await _calculateTimes();


    start_time = DateTime.now();
    while(time_passed.compareTo(full_measure_time) < 0){
      time_passed = DateTime.now().difference(start_time);
      time_passed_m = time_passed.inSeconds / 60;
      bpm = hb_count / time_passed_m;
      y_1 = y;
      y = y_value;
      hb_previous = hb;
      if (y_1 > y){
        hb = true;
      } else {
        hb = false;
      }

      if(hb_previous == false && hb == true){
        hb_count++;
      }

      if (i>chart_length-1){
        initializeChart();
        i = 0;
      }
      data[i] = SensorValue(y:y_value, time:i, barColor: charts.Color(r:255,g:0,b:0));
      i++;
      //setState(() {});
      await Future.delayed(Duration(milliseconds: 200)); //5Hz
    }
    _disableTorch();
    Route route = MaterialPageRoute(builder: (context) => hrResults(bpm: bpm));
    Navigator.pushReplacement(context, route);
  }

  Future<void> _startRead() async{
    //Calibration phase:
    //1) Calculates max and minimum acceptable values
    //2) Calculates the HB threshold
    threshold = 0;
    //temp_threshold = 0;
    hb_count = 0;
    time_paused = Duration(seconds: 0);
    time_passed = Duration(seconds: 0);
    time_passed_m = 0;
    phase = 0;
    bpm = 0.0;
    max_y = 0;
    min_y = 10000;

    await Future.delayed(Duration(seconds: 2));
    await _calculateTimes();
    //int counter = 0;

    //print(counter);
    //threshold = temp_threshold;
    //temp_threshold = 0;
   // counter = 0;

    //calculate when next threshold is set and start time
    phase_end = DateTime.now().add(phase_length);
    start_time = DateTime.now();

    setState(() {});
    bool flag = false;
    //while(DateTime.now().isBefore(stop_time) || DateTime.now().isAtSameMomentAs(stop_time)){
    while(time_passed.compareTo(full_measure_time) < 0){
      double y = y_value;
      // when phase is 0
        if(phase == 0){
          threshold += y;
          threshold = threshold/2;
          if (y > max_y) {
            max_y = y;
          } else if (y < min_y){
            min_y = y;
          }
        }
        //when phase is above zero
        if (phase > 0){
          if (flag == false){
            //threshold = threshold * 0.986;
            max_y = max_y * 1.1;
            min_y = min_y * 0.9;
            flag = true;
          }
          if((y > max_y || y < min_y) && paused == false){
            paused = true;
            start_pause = DateTime.now();
          }else if ((y > max_y || y < min_y) && paused == true){
            temp_pause = DateTime.now().difference(start_pause);
          }else if ((y < max_y && y > min_y) && paused == true){
            paused = false;
            time_paused += temp_pause;
            temp_pause = Duration(seconds: 0);
          }

          time_passed = DateTime.now().difference(start_time)-time_paused-temp_pause;
          time_passed_m = time_passed.inSeconds / 60;
          bpm = hb_count / time_passed_m;

          if (y > threshold){
            hb = true;
            if (hb_previous == false){
              //increment heart beat
              hb_count++;
            }
            hb_previous = true;
          }else{
            hb = false;
            hb_previous = false;
          }
        }

        //increment phase every 5 seconds
        if (DateTime.now().isAtSameMomentAs(phase_end) || DateTime.now().isAfter(phase_end)){
          phase_end = DateTime.now().add(phase_length);
          phase++;
        }

        //counter++;
        await Future.delayed(Duration(milliseconds: (1000 * 50 / 3000).round()));
    }
    _disableTorch();
  }

  Future<void> initializeChart() async{
    for(int i = 0; i<chart_length; i++){
      data[i] = SensorValue(y:60,time:i, barColor: charts.Color.transparent);
    }
  }
  @override
  Widget build(BuildContext context) {
    List<charts.Series<SensorValue, num>> series = [
      charts.Series(
        id: "y_values",
        data: data,
        domainFn: (SensorValue series, _) => series.time,
        measureFn: (SensorValue series, _) => series.y,
        colorFn: (SensorValue series, _) => series.barColor
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Active Heart Rate"),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () =>
          {
            Navigator.pop(context)
          }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: _isCameraInitialized ?
                      controller!.buildPreview() :
                      Container(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[Text(
                          "Instructions: \n Place finger over camera "
                              "\n and press the Heart \n"
                              // "y_value = " + y_value.toStringAsFixed(3) +
                              // "\nthreshold = " + threshold.toStringAsFixed(3) +
                              // "\nmax/min: " + max_y.toStringAsFixed(3) +
                              // "  " + min_y.toStringAsFixed(3) +
                              // // "\ntemp_threshold = " + temp_threshold.toStringAsFixed(3) +
                              // "\nhb? = " + hb.toString() +
                              // "\nphase = " + phase.toString() +
                              // "\nhb_count = " + hb_count.toString() +
                              // "\ntime passed = " + time_passed.inSeconds.toString() + "seconds" +
                              // "\nPaused? = " + paused.toString() +
                              // "\nest.bpm = " + bpm.toStringAsFixed(3)
                      ),
                      RichText(text: TextSpan(
                        style: const TextStyle(fontSize:40, color: Colors.black,),
                        children:<TextSpan>[
                          TextSpan(text: bpm.toStringAsFixed(0),
                              style: const TextStyle(fontWeight: FontWeight.bold)
                          ),TextSpan(text: "bpm",
                          style: const TextStyle(fontSize:20)),
                        ]
                      ))]
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: charts.LineChart(series,
                  domainAxis: charts.NumericAxisSpec(
                    tickProviderSpec:
                      charts.BasicNumericTickProviderSpec(zeroBound: false),
                      viewport: charts.NumericExtents(min_chart, chart_length)
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    tickProviderSpec:
                      charts.BasicNumericTickProviderSpec(zeroBound: false)
                  ),
                  animate: false
                ),
            ),
            Expanded(
                child: Center(
                  child: IconButton(
                    icon: Icon(hb ? Icons.favorite : Icons.favorite_border,
                    size: 50),
                      color: Colors.red,
                    onPressed:(){
                      if (torch == false){
                        _enableTorch();
                        torch = true;
                        initializeChart();
                        //_startRead();
                        _startRead2();
                      }
                      else{
                        _disableTorch();
                        torch = false;
                        Navigator.pop(context);
                      }
                      setState((){});
                    },
                  )
            ))
          ],
        ),
      ),
    );
  }
}
