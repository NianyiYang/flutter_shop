import 'package:flutter/material.dart';

/// 首页跳转控制器
class CurrentIndexProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
