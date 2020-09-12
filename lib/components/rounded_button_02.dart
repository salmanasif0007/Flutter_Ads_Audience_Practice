import 'package:flutter/material.dart';
import 'package:show_wallpaper/constants.dart';

class RoundedButton02 extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton02({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
