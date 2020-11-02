import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdbapp/core/constants/app_constants.dart';
import 'package:tmdbapp/core/constants/route_paths.dart';
import 'package:tmdbapp/core/models/movie.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/views/details_screen.dart';
import 'package:tmdbapp/ui/views/home_screen.dart';
import 'package:tmdbapp/ui/views/login_screen.dart';
import 'package:tmdbapp/ui/views/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: AppConstants.title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kMainColor,
          accentColor: kSecondaryColor,
          scaffoldBackgroundColor: kMainColor),
      initialRoute: RoutePaths.Splash,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case RoutePaths.Splash:
            return MaterialPageRoute(
              builder: (_) => SplashScreen(),
            );
          case RoutePaths.Login:
            return MaterialPageRoute(
              builder: (_) => LoginScreen(),
            );
          case RoutePaths.Home:
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case RoutePaths.Details:
            Movie movie = settings.arguments as Movie;
            return MaterialPageRoute(
                builder: (_) => DetailsScreen(
                      movie: movie,
                    ));
          default:
            return MaterialPageRoute(
                builder: (_) => Scaffold(
                      body: Center(
                          child: Text('No route defined for ${settings.name}')),
                    ));
        }
      },
    );
  }
}
