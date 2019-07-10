import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_goods_list.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> _goodsList = [];

  List<CategoryListData> get goodsList => _goodsList;

  getGoodsList(List<CategoryListData> list) {
    _goodsList = list;
    notifyListeners();
  }
}
