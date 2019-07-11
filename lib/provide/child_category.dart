import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory extends ChangeNotifier {
  // 小类列表
  List<BxMallSubDto> _childCategoryList = [];

  List<BxMallSubDto> get childCategoryList => _childCategoryList;

  getChildCategory(List<BxMallSubDto> list) {
//    _categoryId=id;
    _childIndex = 0;
    //点击大类时，把子类ID清空
    _subId = '';

    _page = 1;
    _noMoreText = '';

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
//    subId = id;

    _page = 1;
    _noMoreText = '';

    notifyListeners();
  }

  // 大类 ID TODO 模拟接口用不到
  String _categoryId = '4';

  // 小类 ID TODO 模拟接口用不到
  String _subId = '';

  // 列表页数
  int _page = 1;

  int get page => _page;

  // 显示更多的标识
  String _noMoreText = '';

  String get noMoreText => _noMoreText;

  // 每次加载完后+1
  addPage() {
    _page++;
  }

  // 改变noMoreText数据
  changeNoMore(String text) {
    _noMoreText = text;
    notifyListeners();
  }
}
