import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';

/// 火爆专区
class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    super.initState();
    getHomePageBelowContent(1).then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('123'),
    );
  }
}
