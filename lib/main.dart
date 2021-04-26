import 'package:e_commerce/core/viewmodel/add_address_view_model.dart';
import 'package:e_commerce/core/viewmodel/auth_view_model.dart';
import 'package:e_commerce/core/viewmodel/bottom_navigation_view_model.dart';
import 'package:e_commerce/core/viewmodel/cart_view_model.dart';
import 'package:e_commerce/core/viewmodel/check_out_view_model.dart';
import 'package:e_commerce/core/viewmodel/delivery_time_view_model.dart';
import 'package:e_commerce/core/viewmodel/favourites_view_model.dart';
import 'package:e_commerce/core/viewmodel/home_view_model.dart';
import 'package:e_commerce/core/viewmodel/account_view_model.dart';
import 'package:e_commerce/utils/translation/translation.dart';
import 'package:e_commerce/view/control_View/control_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => BottomNavigationViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProxyProvider(create: (_) => CartViewModel(),
          update: (BuildContext context,HomeViewModel value, CartViewModel previous) {
          return previous..update(value.productModels);
        },),
        ChangeNotifierProvider(create: (_) => AccountViewModel()),
        ChangeNotifierProvider(create: (_) => CheckOutViewModel()),
        ChangeNotifierProvider(create: (_) => DeliveryTimeViewModel()),
        ChangeNotifierProvider(create: (_) => AddAddressViewModel()),
        ChangeNotifierProxyProvider(create: (_) => FavouritesViewModel(),
          update: (BuildContext context,HomeViewModel value, FavouritesViewModel previous) {
          return previous..update(value.productModels);
          },),
      ],
      child: GetMaterialApp(
        theme: ThemeData(fontFamily: 'sans'),
        translations: Translation(),
        locale: Locale('en'),
        fallbackLocale: Locale('en'),
        debugShowCheckedModeBanner: false,
        home: ControlView(),
      ),
    );
  }
}
