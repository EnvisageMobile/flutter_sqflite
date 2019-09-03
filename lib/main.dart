import 'package:flutter/material.dart';
import 'package:flutter_sqflite/utils/Routes.dart';

import 'screens/AddNote/home/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sqflite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: HomeScreen(),
    );
  }


}
