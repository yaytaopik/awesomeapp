import 'package:flutter/material.dart';

class SwitchView extends ChangeNotifier {
  bool isGrid = true;
  void switchMode () {
    isGrid = true;
    notifyListeners();
  }
}