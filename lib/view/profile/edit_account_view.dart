import 'package:e_commerce/core/viewmodel/auth_view_model.dart';
import 'package:e_commerce/view/circular_progress_indicator_view.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditAccountView extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: authController.isLoading
          ? CircularProgressIndicatorView()
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.45,
                        color: Colors.black,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    'assets/images/Icon_Arrow-Left.png',
                                    color: Colors.white,
                                    fit: BoxFit.fill,
                                    height: 15,
                                    width: 15,

                                  ),
                                ),
                                CustomText(
                                  text: 'Edit Profile',
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (_key.currentState.validate()) {
                                      _key.currentState.save();
                                    }
                                  },
                                  child: CustomText(
                                    text: 'SAVE',
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    color: Colors.transparent,
                                    child: authController.image == null
                                        ? Image.asset(
                                            'assets/images/Avatar.png',
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    )
                                        : Image.file(
                                      authController.image,
                                      fit: BoxFit.fill,
                                      width: 200,
                                      height: 200,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child:
                                      // Pic Image
                                      GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: IconButton(
                                        icon: Icon(Icons.camera_alt_outlined),
                                        color: Colors.white,
                                        onPressed: () async {
                                          await authController.getImage();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _editAccountTextFieldBuilder(
                        initialValue: authController.name,
                        title: 'Username',
                        validator: (String value) {
                          if (value.length < 3)
                            return 'Username is very short!';
                          return null;
                        },
                        onSaved: (String value) async {
                          if (value != authController.name) {
                            await authController.updateUserName(value);
                          }
                        },
                      ),
                      _editAccountTextFieldBuilder(
                        initialValue: authController.email,
                        title: 'Email',
                        validator: (String value) {
                          if (!value.contains('@') ||
                              value.isEmpty ||
                              !value.contains('.')) return 'Invalid email';
                          return null;
                        },
                        onSaved: (String value) async {
                          if (value != authController.email) {
                            await authController.updateUserEmail(value);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

_editAccountTextFieldBuilder(
    {String title, Function validator, Function onSaved, String initialValue}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        TextFormField(
          cursorColor: Colors.grey,
          initialValue: initialValue,
          decoration: InputDecoration(
              labelText: title,
              labelStyle: TextStyle(fontSize: 20, color: Colors.grey)),
          scrollPadding: EdgeInsets.zero,
          validator: validator,
          onSaved: onSaved,
        )
      ],
    ),
  );
}
