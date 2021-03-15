import 'package:flutter/material.dart';
import 'package:memory_project/constants.dart';

class FlatButtonFunction extends StatelessWidget {
  final Function press;
  final Text text;
  const FlatButtonFunction({
    Key key,
    this.press,
    this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            text.data,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
