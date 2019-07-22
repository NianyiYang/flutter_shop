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
        'images': images
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
      // 转换为字符串数组
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
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
}
