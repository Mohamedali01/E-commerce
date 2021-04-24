import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Function validator;
  final Function onSaved;
  final String hintText;
  final bool obscure;

  CustomTextFormField(
      {this.validator, this.onSaved, this.hintText, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      obscureText: obscure,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
