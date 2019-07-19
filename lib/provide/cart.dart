import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 购物车provide
class CartProvide with ChangeNotifier {
  String cartString = "[]";

  save(goodsId, goodsName, count, price, images) async {
    // 初始化 SharedPreferences
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');

    var temp = cartString == null ? [] : json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast();

    var isHave = false;
    int iValue = 0;

    tempList.forEach((item) {
      // 存在则+1
      if (item['goodsId'] == goodsId) {
        tempList[iValue]['count'] = item['count'] + 1;
        isHave = true;
      }

      iValue++;
    });

    // 如果没有，增加
    if (!isHave) {
      tempList.add({
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images
      });
    }

    // 字符串 encode
    cartString = json.encode(tempList).toString();
    sp.setString('cartInfo', cartString);
    
    notifyListeners();
  }
  
  remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('cartInfo');
    
    notifyListeners();
  }
}
