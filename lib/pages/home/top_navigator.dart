import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 顶部导航组件
class TopNavigator extends StatelessWidget {
  final List navList;

  // TODO 看到问题所在没？
//  TopNavigator({key: Key, this.navList}) : super(key: key);
  TopNavigator({Key key, this.navList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (navList.length > 10) {
      navList.removeRange(10, navList.length);
    }

    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
          crossAxisCount: 5,
          padding: EdgeInsets.all(4.0),
          children: navList.map((item) {
            return _gridViewItemUI(context, item);
          }).toList()),
    );
  }

  /// 顶部导航组件的子组件 纯UI展示
  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
//          Icon(CupertinoIcons.video_camera_solid),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }
}