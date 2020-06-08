
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  final double fontsize;
  const RoundedButton({
    this.fontsize,
    Key key,
    this.text,
    this.press,
    this.color ,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15),
          color: Theme.of(context).accentColor ,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: fontsize),
          ),
        ),
      ),
    );
  }
}