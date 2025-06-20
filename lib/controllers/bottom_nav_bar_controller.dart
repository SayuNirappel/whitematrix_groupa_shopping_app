import 'package:flutter/material.dart';

class BottomNavBarController with ChangeNotifier {
  int currentIndex = 0;

  int get cIndex => currentIndex;

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
