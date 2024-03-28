import 'package:flutter/material.dart';

class ButtonReturnController extends ChangeNotifier {
  void updateButton([String? value]) {
    notifyListeners();
  }
}
