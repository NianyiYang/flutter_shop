import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';

/// 商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;
  BuildContext context;

  Recommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      height: ScreenUtil().setHeight(350),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }

  /// 标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  // 列表项
  Widget _item(index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context,"/detail?id=${recommendList[index]['goodsId']}");
      },
      child: Container(
        height: ScreenUtil().setHeight(300),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
            Border(left: BorderSide(color: Colors.black12, width: 0.5))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text(
              '￥${recommendList[index]['mallPrice']}',
            ),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(300),
      child: ListView.builder(
        itemBuilder: (context, index) {
          // 返回 Item 项
          return _item(index);
        },
        itemCount: recommendList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}