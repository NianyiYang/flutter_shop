import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 购物车provide
class CartProvide with ChangeNotifier {
  List<CartInfoModel> _cartList = [];

  List<CartInfoModel> get cartList => _cartList;

  save(goodsId, goodsName, count, price, images) async {
    // 初始化 SharedPreferences
    SharedPreferences sp = await SharedPreferences.getInstance();
    var cartString = sp.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast();

    var isHave = false;
    int iValue = 0;

    tempList.forEach((item) {
      // 存在则+1
      if (item['goodsId'] == goodsId) {
        tempList[iValue]['count'] = item['count'] + 1;
        _cartList[iValue].count++;
        isHave = true;
      }

      iValue++;
    });

    // 如果没有，增加
    if (!isHave) {
      Map<String, dynamic> goods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      tempList.add(goods);
      _cartList.add(CartInfoModel.fromJson(goods));
    }

    // 字符串 encode
    cartString = json.encode(tempList).toString();
    sp.setString('cartInfo', cartString);

    print(cartString);
    print(_cartList.toString());

    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var cartString = sp.getString('cartInfo');

    _cartList = [];

    if (cartString == null) {
      _cartList = [];
    } else {
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      // 转换为字符串数组
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        _cartList.add(CartInfoModel.fromJson(item));
      });
    }

    notifyListeners();
  }

  remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('cartInfo');

    notifyListeners();
  }

  //修改选中状态
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var cartString = sp.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    sp.setString('cartInfo', cartString); //
    await getCartInfo();
  }

  ///点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var cartString = sp.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = []; //新建一个List，用于组成新的持久化数据。
    for (var item in tempList) {
      var newItem = item; //复制新的变量，因为Dart不让循环时修改原值
      newItem['isCheck'] = isCheck; //改变选中状态
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString(); //形成字符串
    sp.setString('cartInfo', cartString); //进行持久化
    await getCartInfo();
  }

  /// 删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var cartString = sp.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    sp.setString('cartInfo', cartString);
    await getCartInfo();
  }

  /// 商品数量增减
  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString); //
    await getCartInfo();
  }

  // 总价
  double allPrice = 0;
  int allGoodsCount = 0;

  bool isAllCheck = true;
}
