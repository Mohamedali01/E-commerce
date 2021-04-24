import 'package:e_commerce/core/viewmodel/account_view_model.dart';
import 'package:e_commerce/view/circular_progress_indicator_view.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  bool _isLoad = false;

  @override
  Widget build(BuildContext context) {
    final accountController =
        Provider.of<AccountViewModel>(context);
    return ((accountController.isLoading == true) || (_isLoad == true))
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
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red,
                              image: DecorationImage(
                                image: AssetImage('assets/images/Avatar.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              CustomText(
                                textOverFlow: true,
                                text: accountController.userModel.name,
                                fontSize: 30,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                textOverFlow: true,
                                fontSize: 18,
                                text: accountController.userModel.email,
                                color: Colors.black,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      _profileItemWidget('Edit Profile',
                          'assets/profileIcons/Icon_Edit-Profile.png'),
                      _profileItemWidget('Shipping Address',
                          'assets/profileIcons/Icon_Location.png'),
                      _profileItemWidget('Order History',
                          'assets/profileIcons/Icon_History.png'),
                      _profileItemWidget(
                          'Cards', 'assets/profileIcons/Icon_Payment.png'),
                      _profileItemWidget('Notifications',
                          'assets/profileIcons/Icon_Alert.png'),
                      _profileItemWidget(
                        'Log Out',
                        'assets/profileIcons/Icon_Exit.png',
                        onTap: () async {
                          setState(() {
                            _isLoad = true;
                          });
                          await accountController.signOut();
                          setState(() {
                            _isLoad = false;
                          });
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

_profileItemWidget(String text, String icon, {Function onTap}) {
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
