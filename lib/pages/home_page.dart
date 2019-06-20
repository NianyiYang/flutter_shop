import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// 混入保持页面状态 step 3 AutomaticKeepAliveClientMixin
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
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

            String phoneResource = data['data']['contact']['image'].toString();
            String phoneNumber = data['data']['contact']['number'].toString();

            List<Map> recommendList =
                (data['data']['recommend'] as List).cast();

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SwiperDiy(swiperList: swiperDataList),
                  TopNavigator(navList: navDataList),
                  AdBanner(adResource: adResource),
                  Phone(phoneResource: phoneResource, phoneNumber: phoneNumber),
                  Recommend(recommendList: recommendList)
                ],
              ),
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

  // 混入保持页面状态 step 4
  @override
  bool get wantKeepAlive => true;
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
      height: ScreenUtil().setHeight(250),
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
      height: ScreenUtil().setHeight(260),
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
    print('广告组件');
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Image.network(adResource, fit: BoxFit.fill),
    );
  }
}

/// 电话组件
class Phone extends StatelessWidget {
  final String phoneResource;
  final String phoneNumber;

  Phone({Key key, this.phoneResource, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network(phoneResource, fit: BoxFit.fill),
      ),
    );
  }

  void _launchUrl() async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

/// 商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
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
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
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
      height: ScreenUtil().setHeight(330),
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
