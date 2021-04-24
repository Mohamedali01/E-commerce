import 'package:e_commerce/constants.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double fontSize;

  CustomButton({this.onPressed, this.text,this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(17)),
        backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      onPressed: onPressed,
      child: CustomText(
        text: text,
        color: Colors.white,
        fontSize: fontSize,
        alignment: Alignment.center,
      ),
    );
  }
}
