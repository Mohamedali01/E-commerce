import 'package:e_commerce/core/viewmodel/account_view_model.dart';
import 'package:e_commerce/core/viewmodel/auth_view_model.dart';
import 'package:e_commerce/view/circular_progress_indicator_view.dart';
import 'package:e_commerce/view/profile/edit_account_view.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    final accountController = Provider.of<AccountViewModel>(context);
    final authController = Provider.of<AuthViewModel>(context);
    return (accountController.isLoading)
        ? CircularProgressIndicatorView()
        : Scaffold(
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            color: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 120,
                                height: 120,
                                child: authController.image == null
                                    ? Image.asset('assets/images/Avatar.png',
                                fit: BoxFit.fill,
                                )
                                    : Image.file(
                                        authController.image,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    authController.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  authController.email,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      _profileItemWidget('Edit Profile',
                          'assets/profileIcons/Icon_Edit-Profile.png', () {
                        print('Mohamed Ali Edit Account pressed');
                        Get.to(EditAccountView());
                      }),
                      _profileItemWidget('Shipping Address',
                          'assets/profileIcons/Icon_Location.png', () {}),
                      _profileItemWidget('Order History',
                          'assets/profileIcons/Icon_History.png', () {}),
                      _profileItemWidget('Cards',
                          'assets/profileIcons/Icon_Payment.png', () {}),
                      _profileItemWidget('Notifications',
                          'assets/profileIcons/Icon_Alert.png', () {}),
                      _profileItemWidget(
                        'Log Out',
                        'assets/profileIcons/Icon_Exit.png',
                        () async {
                          await accountController.signOut();
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

_profileItemWidget(String text, String icon, Function onTap) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          child: ListTile(
            title: CustomText(
              text: text,
              fontSize: 18,
            ),
            leading: Container(
              width: 40,
              height: 40,
              child: Image.asset(
                icon,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 17,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 15,
      )
    ],
  );
}
