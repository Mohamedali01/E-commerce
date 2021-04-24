import 'package:e_commerce/core/viewmodel/auth_view_model.dart';
import 'package:e_commerce/view/auth/sign_up_view.dart';
import 'package:e_commerce/view/circular_progress_indicator_view.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_social_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthViewModel>(context);
    return controller.isLoading
        ? CircularProgressIndicatorView()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  color: Colors.black,
                                  fontSize: 30,
                                  text: 'Welcome,',
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(SignUpView());
                                  },
                                  child: CustomText(
                                    color: kPrimaryColor,
                                    text: "Sign Up",
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              fontSize: 14,
                              text: "Sign in to Continue",
                              color: Color.fromRGBO(146, 146, 146, 1),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            CustomText(
                              color: Color.fromRGBO(189, 196, 204, 1),
                              text: "Email",
                              fontSize: 14,
                            ),
                            CustomTextFormField(
                              obscure: false,
                              hintText: 'iamdavid@gmail.com',
                              onSaved: (value) {
                                controller.email = value;
                              },
                              validator: (value) {
                                if (value == null)
                                  return 'Enter the email!';
                                else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            CustomText(
                              color: Color.fromRGBO(189, 196, 204, 1),
                              text: "Password",
                              fontSize: 14,
                            ),
                            CustomTextFormField(
                              obscure: true,
                              hintText: "*************",
                              validator: (value) {
                                if (value == null)
                                  return 'Enter the password!';
                                else
                                  return null;
                              },
                              onSaved: (value) {
                                controller.password = value;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              fontSize: 16,
                              text: "Forgot Password?",
                              color: Colors.black,
                              alignment: Alignment.topRight,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              text: "SIGN IN",
                              onPressed: () async {
                                if (_key.currentState.validate()) {
                                  _key.currentState.save();
                                  await controller.signInWithEmailAndPass();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: '-OR-',
                    alignment: Alignment.center,
                    fontSize: 18,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomSocialButton(
                    onPressed: () async {
                      await controller.signInFacebookAuth();
                    },
                    text: 'Sign in with Facebook',
                    imageName: 'assets/images/facebook.png',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomSocialButton(
                    onPressed: () async {
                      await controller.signInGoogleAuth();
                    },
                    text: 'Sign in with Google',
                    imageName: 'assets/images/google.png',
                  )
                ],
              ),
            ),
          );
  }
}
