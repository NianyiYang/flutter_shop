import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/routers/routes.dart';
import 'package:provide/provide.dart';

import 'provide/counter.dart';

void main() {
  // step 2 引入 Provider
  var providers = Providers();

  var counter = Counter();
  var childCategory = ChildCategory();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider.function((context) => childCategory))
    ..provide(Provider.function((context) => CategoryGoodsListProvide()))
    ..provide(Provider.function((context) => DetailsInfoProvide()))
    ..provide(Provider.function((context) => CartProvide()));

  // step 3 封装了InheritWidget的ProviderNode
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO 注入路由
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
          title: '百姓生活+',
          debugShowCheckedModeBanner: false,
          // TODO 注入路由
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(primaryColor: Colors.pink),
          home: IndexPage()),
    );
  }
}
