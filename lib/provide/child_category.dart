import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory extends ChangeNotifier {
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
}
