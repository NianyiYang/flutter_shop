import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:provide/provide.dart';

/// 右侧子类导航
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(builder: (context, child, childCategory) {
      return Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: childCategory.childCategoryList.length,
          itemBuilder: (context, index) {
            return _rightInkWell(childCategory.childCategoryList[index]);
          },
        ),
      );
    });
  }

  Widget _rightInkWell(BxMallSubDto item) => InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
          child: Text(
            item.mallSubName,
            style: TextStyle(fontSize: ScreenUtil().setSp(28)),
          ),
        ),
      );
}
