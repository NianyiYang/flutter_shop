import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory extends ChangeNotifier {

  // 小类列表
  List<BxMallSubDto> _childCategoryList = [];

  List<BxMallSubDto> get childCategoryList => _childCategoryList;

  getChildCategory(List<BxMallSubDto> list) {
    // 添加【全部】
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    _childCategoryList = [all];
    _childCategoryList.addAll(list);
    notifyListeners();
  }

  // 高亮位置
  int _childIndex = 0;

  int get childIndex => _childIndex;

  // 改变子类索引
  changeChildIndex(int index) {
    _childIndex = index;
    notifyListeners();
  }
}
