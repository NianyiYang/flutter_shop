import 'package:flutter/material.dart';

/// 计数器数据 Provider
class Counter extends ChangeNotifier {

  // TODO 这个地方相对于技术胖的博客有改动
  int _value = 0;

  int get value => _value;

  increment() {
    _value++;
    notifyListeners();
  }
}
