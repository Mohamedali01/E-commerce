import 'package:flutter/material.dart';

class AddAddressViewModel with ChangeNotifier{

  String street1, street2, city, state, country;
  GlobalKey key  = GlobalKey<FormState>();
}

