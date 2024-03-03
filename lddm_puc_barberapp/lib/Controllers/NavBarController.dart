import 'package:flutter/material.dart';

class NavBarController extends ChangeNotifier {
  int actualIndex = 0;

  void changeIndex(int i) {
    actualIndex = i;
    notifyListeners();
  }
}