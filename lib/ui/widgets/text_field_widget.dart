import 'package:flutter/material.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color color;
  final Function validation;
  final bool isObscureText;

  TextFieldWidget(
      {Key key,
      this.controller,
      this.validation,
      this.color,
      this.label,
      this.icon,
      this.isObscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      controller: controller,
      style: TextStyle(color: color),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: kThirdColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: color,
              width: 2.0,
            ),
          ),
          icon: Icon(
            icon,
            color: color,
          ),
          labelText: label,
          labelStyle: TextStyle(color: color)),
      validator: validation,
    );
  }
}
