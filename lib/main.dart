import 'package:flutter/material.dart';
import 'package:flutter_blue_app/screens/wrapper.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Wrapper());
  }
}