import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel _goodsInfo = null;

  DetailsModel get goodsInfo => _goodsInfo;

  // 请求商品信息
  void getGoodsInfo(String id) {
    var formData = {'goodId': id};

    request('getGoodDetailById').then((val){
      var responseData = val;
      _goodsInfo = DetailsModel.fromJson(responseData);

      notifyListeners();
    });
  }
}
