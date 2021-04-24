import 'package:e_commerce/utils/languages/ar.dart';
import 'package:e_commerce/utils/languages/en.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {'ar': ar, 'en': en};
  }
}
