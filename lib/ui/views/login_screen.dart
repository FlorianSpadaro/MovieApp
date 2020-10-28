import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:tmdbapp/core/models/movie.dart';
import 'package:tmdbapp/core/services/api.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/shared/app_styles.dart';
import 'package:tmdbapp/ui/views/splash_screen.dart';
import 'package:tmdbapp/ui/widgets/authentication/login_widget.dart';
import 'package:tmdbapp/ui/widgets/authentication/sign_in_widget.dart';
import 'package:tmdbapp/ui/widgets/authentication/sign_up_wiget.dart';
import 'package:tmdbapp/ui/widgets/logo_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Api api = Api();
  LoginWidget loginWidget;
  SignInWidget signInWidget;
  SingUpWidget singUpWidget;
  Widget widgetToShow;

  @override
  void initState() {
    super.initState();
    signInWidget = SignInWidget(
        onBack: () => setState(() {
              widgetToShow = loginWidget;
            }));
    singUpWidget = SingUpWidget(
        onBack: () => setState(() {
              widgetToShow = loginWidget;
            }));
    loginWidget = LoginWidget(
      onTapSignInBtn: () {
        setState(() {
          widgetToShow = signInWidget;
        });
      },
      onTapSignUpBtn: () {
        setState(() {
          widgetToShow = singUpWidget;
        });
      },
    );
    widgetToShow = loginWidget;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movie>(
        future: api.getMostPopularMovie(),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Movie movie = snapshot.data;
            return KeyboardDismissOnTap(
              child: Stack(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                            visible:
                                MediaQuery.of(context).viewInsets.bottom == 0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 50.0, right: 50.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LogoWidget(
                                      color: kThirdColor,
                                      height: 80.0,
                                      width: 80.0),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Millions of films, series and artists to discover ...',
                                    style: kMainTitleTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          widgetToShow
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return ErrorWidget(snapshot.error);
          }
          return SplashScreen();
        });
  }

  void onBack() {}
}
