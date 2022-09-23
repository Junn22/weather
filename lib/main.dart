import 'package:flutter/material.dart';
import 'package:weather_jun_app/screens/loading.dart';
import 'package:geolocator/geolocator.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Loading(),
      )
    );
  }
}



