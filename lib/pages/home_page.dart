import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayText = '加载中...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;

            List<Map> swiperDataList = (data['data']['slides'] as List).cast();

            List<Map> navDataList = (data['data']['category'] as List).cast();

            String adResource = data['data']['adResource'].toString();

            return Column(
              children: <Widget>[
                SwiperDiy(swiperList: swiperDataList),
                TopNavigator(navList: navDataList),
                AdBanner(adResource: adResource)
              ],
            );
          } else {
            return Center(
              child: Text(displayText),
            );
          }
        },
      ),
    );
  }
}

/// 轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperList;

  SwiperDiy({Key key, this.swiperList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 初始化设计稿尺寸
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print('设备宽度:${ScreenUtil.screenWidth}');
    print('设备高度:${ScreenUtil.screenHeight}');
    print('设备像素密度:${ScreenUtil.pixelRatio}');

    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

/// 顶部导航组件
class TopNavigator extends StatelessWidget {
  final List navList;

  // TODO 看到问题所在没？
//  TopNavigator({key: Key, this.navList}) : super(key: key);
  TopNavigator({Key key, this.navList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
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
            item['icon'],
            width: ScreenUtil().setWidth(95),
          ),
//          Icon(CupertinoIcons.video_camera_solid),
          Text(item['name'])
        ],
      ),
    );
  }
}

/// 广告组件
class AdBanner extends StatelessWidget {
  final String adResource;

  AdBanner({Key key, this.adResource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      child: Image.network(adResource, fit: BoxFit.fill),
    );
  }
}
