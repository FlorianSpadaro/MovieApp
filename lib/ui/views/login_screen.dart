import 'package:flutter/material.dart';
import 'package:tmdbapp/core/models/movie.dart';
import 'package:tmdbapp/core/services/api.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/shared/app_styles.dart';
import 'package:tmdbapp/ui/views/splash_screen.dart';
import 'package:tmdbapp/ui/widgets/logo_widget.dart';
import 'package:tmdbapp/ui/widgets/rounded_button_widget.dart';

class LoginScreen extends StatelessWidget {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movie>(
        future: api.getMostPopularMovie(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Movie movie = snapshot.data;
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: kMainColor,
                  child: Image.network(
                    movie.backdropImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent.withOpacity(0.5),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LogoWidget(
                                  color: Colors.orangeAccent,
                                  height: 80.0,
                                  width: 80.0),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Millions of films, series and artists to discover ...',
                                style: kMainTitleTextStyle,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              RoundedButton(
                                color: kMainColor,
                                text: 'Sign up',
                                textColor: kSecondaryColor,
                                onTap: () => null,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              RoundedButton(
                                color: kSecondaryColor,
                                text: 'Sign in',
                                textColor: kMainColor,
                                onTap: () => null,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return ErrorWidget(snapshot.error);
          }
          return SplashScreen();
        });
  }
}
