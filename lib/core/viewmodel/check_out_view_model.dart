import 'package:e_commerce/view/control_View/control_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutViewModel with ChangeNotifier {
  List<bool> _list = [false, false, false];
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();


  List<bool> get list => _list;

  int _currentStep = 0;

  int get currentStep => _currentStep;

  void goTo(int index) {
    _currentStep = index;
    print('Mohamed Ali current Step = $_currentStep');
    notifyListeners();
  }

  void cancel() {
    if (_currentStep > 0) {
      _list[_currentStep - 1] = false;

      notifyListeners();
      _currentStep--;
      goTo(_currentStep);
    } else {
      _list[_currentStep] = false;
      notifyListeners();
      Get.offAll(ControlView());
    }
  }

  void continueSteps() {
    if (_currentStep == 1) {
      if (globalKey.currentState.validate()) {
        globalKey.currentState.save();
        _list[_currentStep] = true;

        _currentStep++;
        notifyListeners();
      }
    } else {
      if (_currentStep < 2) {
        _list[_currentStep] = true;
        notifyListeners();
        _currentStep++;
        goTo(_currentStep);
      } else {
        _list[_currentStep] = true;
        notifyListeners();
        for (int i = 0; i < 3; i++) {
          _list[i] = false;
          notifyListeners();
        }
        Get.offAll(ControlView());
        _currentStep = 0;
      }
    }
  }
}
