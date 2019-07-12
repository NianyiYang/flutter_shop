import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/details_page.dart';

/// 路由规则处理类 Handler 是 fluro 中的
Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params) {
    String goodsId = params['id'].first;
//    print('index>details goodsID is ${goodsId}');
    return DetailsPage(goodsId);
  }
);