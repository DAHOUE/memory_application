import 'package:flutter/material.dart';

class TextWithStyle extends StatelessWidget {
  final String text;
  final Color colors;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  TextWithStyle({Key key, 
    this.text, this.colors, this.fontSize, this.textAlign, this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
