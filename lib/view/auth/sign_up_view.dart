import 'package:e_commerce/core/viewmodel/auth_view_model.dart';
import 'package:e_commerce/view/circular_progress_indicator_view.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'login_view.dart';

class SignUpView extends StatelessWidget {
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
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Get.offAll(LoginView());
                  }),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                          key: _key,
                          child: Column(
                            children: [
                              CustomText(
                                color: Colors.black,
                                fontSize: 30,
                                text: 'Sign Up',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                color: Color.fromRGBO(189, 196, 204, 1),
                                text: "Name",
                                fontSize: 14,
                              ),
                              CustomTextFormField(
                                obscure: false,
                                hintText: 'Mohamed',
                                onSaved: (value) {
                                  controller.name = value;
                                },
                                validator: (String value) {
                                  if (value.isEmpty)
                                    return 'Enter the name!';
                                  else
                                    return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
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
                                validator: (String value) {
                                  if (value.isEmpty)
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
                                validator: (String value) {
                                  if (value.isEmpty)
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
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: Checkbox(
                                  value: controller.isAdmin,
                                  onChanged: (newValue) {
                                    controller.isAdminChanged(newValue);
                                  },
                                ),
                                title: Text('Sign up as admin'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                text: "SIGN UP",
                                onPressed: () async {
                                  if (_key.currentState.validate()) {
                                    _key.currentState.save();
                                    await controller
                                        .createUserWithEmailAndPass();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
