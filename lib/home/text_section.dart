import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TextSection extends StatelessWidget {
  final String _title, _body;
  final Color color, color2; 
  final num size, size2, spacing;
  final padding, padding2, weight, decoration;

  TextSection(
    this._title, 
    this._body, 
    {
      this.color = Colors.white, 
      this.color2 = Colors.white, 
      this.size = 24.0, 
      this.size2 = 18.0, 
      this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 4), 
      this.padding2 = const EdgeInsets.fromLTRB(16, 10, 16, 16), 
      this.spacing = 2.0,
      this.weight = FontWeight.w500, 
      this.decoration 
    }
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: this.padding,
          child: Text(
            this._title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Dosis', 
              fontWeight: this.weight,
              fontSize: this.size, 
              letterSpacing: this.spacing, 
              color: this.color,
              decoration: this.decoration
            )
          )
        ), 
        Container(
          padding: this.padding2,
          child: Text(
            this._body,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Dosis',
              fontWeight: FontWeight.w400,
              fontSize: this.size2,
              letterSpacing: 1.5, 
              color: this.color2
            )
          )
        )
      ],
    );
  }
}

class CardPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0
      )
    );
  }
}

class CellText extends StatelessWidget {
  final String _text;
  final num _size, spacing;
  final bool isBold;

  CellText(
    this._text, 
    this._size, 
    [
      this.isBold = false,
      this.spacing = 1.0
    ]
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      this._text,
      textAlign: TextAlign.center,
      style: TextStyle( 
        fontFamily: 'Dosis', 
        fontWeight: (isBold) ? FontWeight.bold : FontWeight.w500, 
        fontSize: this._size, 
        letterSpacing: this.spacing
      ) 
    );
  }
}