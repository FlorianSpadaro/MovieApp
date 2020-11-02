import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;

  LoadingWidget({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: color,
      ),
    );
  }
}
