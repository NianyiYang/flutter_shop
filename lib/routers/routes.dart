
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/routers/router_handler.dart';

/// 总的路由配置
class Routes {

  // 根节点
  static String root = '/';

  // 详情页
  static String detailsPage = '/detail';

  // 配置
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context ,Map<String ,List<String>> params) {
        print('路由未找到');
      }
    );

    // 对应的路由规则
    router.define(detailsPage, handler: detailsHandler);
  }
}