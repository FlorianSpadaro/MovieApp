import 'package:flutter/material.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/widgets/rounded_button_widget.dart';

class LoginWidget extends StatelessWidget {
  final Function onTapSignUpBtn;
  final Function onTapSignInBtn;
  LoginWidget({Key key, this.onTapSignInBtn, this.onTapSignUpBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0, left: 50.0, right: 50.0),
      child: Column(
        children: [
          RoundedButton(
            color: kMainColor,
            text: 'Sign up',
            textColor: kSecondaryColor,
            onTap: onTapSignUpBtn,
          ),
          SizedBox(
            height: 20.0,
          ),
          RoundedButton(
            color: kSecondaryColor,
            text: 'Sign in',
            textColor: kMainColor,
            onTap: onTapSignInBtn,
          )
        ],
      ),
    );
  }
}
