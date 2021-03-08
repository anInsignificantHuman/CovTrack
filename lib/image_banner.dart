import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ImageBanner extends StatelessWidget { 
  final String _path; 

  ImageBanner(this._path);

  @override 
  Widget build(BuildContext context) {
    return Card(
      elevation: 100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Image.asset(
        this._path, 
        fit: BoxFit.fill
      )
    );
  }
}