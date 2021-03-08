import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../home/menu.dart';
 
class Resources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CovTrack',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,
          title: Text(
            'Resources',
            style: TextStyle(
              fontFamily: 'Dosis',
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
              letterSpacing: 1.25
            )
          ),
        ),
        drawer: Menu("resources")
      ),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark
      ) 
    );
  }
}