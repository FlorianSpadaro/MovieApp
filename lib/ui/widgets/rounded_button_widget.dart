import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final String text;
  final Color textColor;

  RoundedButton(
      {Key key,
      @required this.onTap,
      @required this.color,
      @required this.text,
      @required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _height = 80.0;
    const double _padding = 10.0;

    return InkWell(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          height: _height,
          padding: const EdgeInsets.all(_padding),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(_height / 2)),
          child: Text(
            text,
            textScaleFactor: 1.3,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          )),
    );
  }
}
