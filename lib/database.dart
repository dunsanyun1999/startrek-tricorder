import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class Profile{
  final int id;
  final String name;
  final int age;
  final bool is_male;

  const Profile({
    required this.id,
    required this.name,
    required this.age,
    required this.is_male
  });
}
