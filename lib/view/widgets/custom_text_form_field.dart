import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Function validator;
  final Function onSaved;
  final String hintText;
  final bool obscure;
  final String initialValue;

  CustomTextFormField(
      {this.validator, this.onSaved, this.hintText, this.obscure = false,this.initialValue =''});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
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
