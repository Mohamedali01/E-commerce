import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomSocialButton extends StatelessWidget {
  final String text;
  final String imageName;
  final Function onPressed;

  CustomSocialButton({this.text, this.imageName,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Image.asset(
            imageName,
            scale: 1.5,
          ),
          SizedBox(
            width: 80,
          ),
          CustomText(
            fontSize: 16,
            text: text,
          ),
        ],
      ),
    );
  }
}
