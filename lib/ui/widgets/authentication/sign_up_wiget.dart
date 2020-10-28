import 'package:flutter/material.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/widgets/bottom_form_widget.dart';
import 'package:tmdbapp/ui/widgets/text_field_widget.dart';

class SingUpWidget extends StatelessWidget {
  final Function onBack;
  SingUpWidget({Key key, this.onBack}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BottomFormWidget(
        title: 'Sign up',
        form: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFieldWidget(
                color: kSecondaryColor,
                icon: Icons.mail_outline,
                label: 'Email',
                validation: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFieldWidget(
                color: kSecondaryColor,
                icon: Icons.lock_outline,
                label: 'Password',
                validation: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFieldWidget(
                color: kSecondaryColor,
                icon: Icons.lock_outline,
                label: 'Confirmation',
                validation: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ])),
        submitLabel: 'Create account',
        onSubmit: () {
          if (_formKey.currentState.validate()) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data')));
          }
        },
        onBack: onBack,
        mainColor: kMainColor,
        secondaryColor: kSecondaryColor);
  }
}
