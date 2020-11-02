import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWidget extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  LogoWidget(
      {@required this.color, @required this.height, @required this.width});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "logo",
      child: Container(
        width: width,
        height: height,
        child: SvgPicture.asset(
          'assets/images/tmdb_logo.svg',
          semanticsLabel: 'TMDB Logo',
          color: color,
        ),
      ),
    );
  }
}
