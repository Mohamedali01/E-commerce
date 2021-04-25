import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Image.asset(
        'assets/images/Content.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    ));
  }
}
