import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tmdbapp/core/constants/route_paths.dart';
import 'package:tmdbapp/core/services/authentication.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/widgets/logo_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp().then((value) {
      Authentication authentication = Authentication();
      authentication.getCurrentUser();
      Future.delayed(Duration(seconds: 2)).then((value) =>
          Navigator.popAndPushNamed(
              context,
              authentication.currentUser == null
                  ? RoutePaths.Login
                  : RoutePaths.Home));
    });
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
