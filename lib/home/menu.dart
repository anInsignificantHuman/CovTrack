import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'home.dart';
import '../resources/resources.dart';
import '../info/info.dart';

class Menu extends StatelessWidget {
  final String currentRoute; 

  Menu(this.currentRoute);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
          AppBar(
            centerTitle: true,
            title: Text(
              'Menu',
              style: TextStyle(
                fontFamily: 'Dosis',
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
                letterSpacing: 1.25
              )
            ),
          ),
          ListTile(
            onTap: (this.currentRoute == "home") ? () {} : () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home(whoCases, whoDeaths, dataTable))
            ),
            leading: Icon(
              Icons.home,
              color: (this.currentRoute == "home") ? Colors.white : Colors.grey[400]
            ),
            title: Text(
              'Home', 
              style: TextStyle(
                color: (this.currentRoute == "home") ? Colors.white : Colors.grey[400],
                fontFamily: 'Dosis', 
                fontWeight: FontWeight.w700, 
                fontSize: 20.0, 
                letterSpacing: 1.5 
              )
            )
          ), 
          ListTile(
            onTap: (this.currentRoute == "info") ? () {} : () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Info())
            ),
            leading: Icon(
              Icons.info,
              color: (this.currentRoute == "info") ? Colors.white : Colors.grey[400]
            ),
            title: Text(
              'Info', 
              style: TextStyle(
                color: (this.currentRoute == "info") ? Colors.white : Colors.grey[400],
                fontFamily: 'Dosis', 
                fontWeight: FontWeight.w700, 
                fontSize: 20.0, 
                letterSpacing: 1.5 
              )
            )
          ),
          ListTile( 
            onTap: (this.currentRoute == "resources") ? () {} : () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Resources())
            ),
            leading: Icon(
              Icons.source,
              color: (this.currentRoute == "resources") ? Colors.white : Colors.grey[400]
            ), 
            title: Text(
              'Resources', 
              style: TextStyle(
                color: (this.currentRoute == "resources") ? Colors.white : Colors.grey[400],
                fontFamily: 'Dosis', 
                fontWeight: FontWeight.w700, 
                fontSize: 20.0, 
                letterSpacing: 1.5 
              )
            )
          )
        ]
      )
    );
  }
}