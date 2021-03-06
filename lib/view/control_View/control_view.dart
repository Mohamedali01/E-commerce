import 'package:e_commerce/core/viewmodel/auth_view_model.dart';
import 'package:e_commerce/core/viewmodel/bottom_navigation_view_model.dart';
import 'package:e_commerce/core/viewmodel/cart_view_model.dart';
import 'package:e_commerce/core/viewmodel/favourites_view_model.dart';
import 'package:e_commerce/view/auth/login_view.dart';
import 'package:e_commerce/view/circular_progress_indicator_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
CartViewModel cartProvider1;
FavouritesViewModel favProvider1;

class ControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cartProvider1 = Provider.of<CartViewModel>(context);
    favProvider1 = Provider.of<FavouritesViewModel>(context);
    final data = Provider.of<BottomNavigationViewModel>(context);
    final controller = Provider.of<AuthViewModel>(context);
    return !controller.isAuth()
        ? LoginView()
        : FutureBuilder(
            future: controller.autoLogin(),
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.done)
              return Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: data.index,
                    onTap: (index) {
                      data.changeState(index);
                    },
                    elevation: 0,
                    items: [
                      BottomNavigationBarItem(
                        label: '',
                        icon: Tooltip(
                            message: 'Explore',
                            child: Image.asset('assets/images/Icon_Explore.png')),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Text('Explore'),
                              Text(
                                '.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: '',
                        icon: Tooltip(
                            message: 'Cart',
                            child: Image.asset('assets/images/Icon_Cart.png')),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Text('Cart'),
                              Text(
                                '.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: '',
                        icon: Tooltip(
                            message: 'Account',
                            child: Image.asset('assets/images/Path 5.png')),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              Text('Account'),
                              Text(
                                '.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: data.currentView);
            });
  }
}
