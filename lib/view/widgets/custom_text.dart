import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final Alignment alignment;
  final bool bold;
  final bool textOverFlow;

  CustomText(
      {this.text = '',
      this.fontSize = 14,
      this.color = Colors.black,
      this.alignment = Alignment.topLeft,
      this.bold = false,
      this.textOverFlow = false
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        overflow: textOverFlow ? TextOverflow.ellipsis :null,
        style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: bold ? FontWeight.w600 : null),
      ),
    );
  }
}
