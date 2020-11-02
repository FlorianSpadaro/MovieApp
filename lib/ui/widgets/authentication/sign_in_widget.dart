import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tmdbapp/core/constants/route_paths.dart';
import 'package:tmdbapp/core/services/authentication.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/widgets/bottom_form_widget.dart';
import 'package:tmdbapp/ui/widgets/text_field_widget.dart';

class SignInWidget extends StatefulWidget {
  final Function onBack;
  final Authentication authentication;
  SignInWidget({Key key, @required this.authentication, this.onBack})
      : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BottomFormWidget(
        isLoading: _isLoading,
        title: 'Sign in',
        form: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFieldWidget(
                controller: _emailController,
                color: kMainColor,
                icon: Icons.mail_outline,
                label: 'Email',
                validation: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  } else if (!EmailValidator.validate(_emailController.text)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFieldWidget(
                controller: _passwordController,
                isObscureText: true,
                color: kMainColor,
                icon: Icons.lock_outline,
                label: 'Password',
                validation: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ])),
        submitLabel: 'Login',
        onSubmit: () async {
          if (_formKey.currentState.validate()) {
            isLoading(true);
            String error = await widget.authentication
                .login(_emailController.text, _passwordController.text);
            isLoading(false);
            error == null
                ? Navigator.pushNamed(context, RoutePaths.Home)
                : Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text(error)));
          }
        },
        onBack: widget.onBack,
        mainColor: kSecondaryColor,
        secondaryColor: kMainColor);
  }

  void isLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
}
