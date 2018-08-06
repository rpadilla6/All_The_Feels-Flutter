import 'package:all_the_feels_flutter/ui/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
        backgroundColor: Colors.lightBlue,
        accentColor: Colors.white,
      ),
      title: 'All The Feels',
      home: new HomePage(),
    );
  }
}
