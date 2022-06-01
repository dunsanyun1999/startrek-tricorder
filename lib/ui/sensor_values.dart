import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class SensorValue {
  double y;
  int time;
  charts.Color barColor;

  SensorValue(
    {
      required this.y,
      required this.time,
      required this.barColor
    }
  );

}