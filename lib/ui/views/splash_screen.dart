import 'package:flutter/material.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/widgets/logo_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LogoWidget(
          color: kSecondaryColor,
          width: 150.0,
          height: 150.0,
        ),
      ),
    );
  }
}
