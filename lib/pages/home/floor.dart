import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Floor extends StatelessWidget {
  final String imageUrl;
  final List floorItemList;

  Floor({Key key, this.imageUrl, this.floorItemList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FloorTitle(imageUrl: imageUrl),
          FloorContent(floorItemList: floorItemList),
        ],
      ),
    );
  }
}

/// 楼层标题
class FloorTitle extends StatelessWidget {
  final String imageUrl;

  FloorTitle({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(
        imageUrl,
        fit: BoxFit.fill,
      ),
    );
  }
}

/// 楼层商品
class FloorContent extends StatelessWidget {
  final List floorItemList;

  FloorContent({Key key, this.floorItemList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _nextRow(),
        ],
      ),
    );
  }

  /// 单个商品
  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          print('点击楼层商品');
        },
        child: Image.network(goods['image']),
      ),
    );
  }

  /// 前三个商品 TODO:这个组件感觉好low鸡...与数据格式强耦合
  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorItemList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorItemList[1]),
            _goodsItem(floorItemList[2]),
          ],
        ),
      ],
    );
  }

  /// 第二层商品
  Widget _nextRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorItemList[3]),
        _goodsItem(floorItemList[4]),
      ],
    );
  }
}
