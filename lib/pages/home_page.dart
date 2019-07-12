import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'home/ad_banner.dart';
import 'home/floor.dart';
import 'home/phone_area.dart';
import 'home/recommend.dart';
import 'home/swiper_diy.dart';
import 'home/top_navigator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// 混入保持页面状态 step 3 AutomaticKeepAliveClientMixin
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String displayText = '加载中...';

  int page = 1;
  List<Map> hotGoodsList = [];

  // refresh footer
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

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

            String adResource =
                data['data']['advertesPicture']['PICTURE_ADDRESS'].toString();

            String phoneResource =
                data['data']['shopInfo']['leaderImage'].toString();
            String phoneNumber =
                data['data']['shopInfo']['leaderPhone'].toString();

            List<Map> recommendList =
                (data['data']['recommend'] as List).cast();

            //楼层的标题图片
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];

            //楼层商品和图片
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            List<Map> floor3 = (data['data']['floor3'] as List).cast();

            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中',
                loadReadyText: '上拉加载...',
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperList: swiperDataList),
                  TopNavigator(navList: navDataList),
                  AdBanner(adResource: adResource),
                  Phone(phoneResource: phoneResource, phoneNumber: phoneNumber),
                  Recommend(recommendList: recommendList),
                  Floor(imageUrl: floor1Title, floorItemList: floor1),
                  Floor(imageUrl: floor2Title, floorItemList: floor2),
                  Floor(imageUrl: floor3Title, floorItemList: floor3),
                  _hotGoods(),
                ],
              ),
              loadMore: () async {
                more();
              },
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

  /// 组合火爆专区 TODO 这么写耦合度太高，先这样吧
  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }

  //火爆商品接口
  void _getHotGoods() {
    // TODO 模拟接口 没有页面参数...
//    var formPage = {'page': page};
    print(page);
    request('homePageBelowContent' /*, formData: formPage*/).then((value) {
      var data = value;
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  void more() {
    _getHotGoods();
  }

  /// 火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 0.5, color: Colors.black12),
      ),
    ),
    child: Text('火爆专区'),
  );

  /// Wrap 流式布局
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      // 构建 list 子项
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
            onTap: () {
              Application.router
                  .navigateTo(context, "/detail?id=${val['goodsId']}");
            },
            child: Container(
              width: ScreenUtil().setWidth(372),
              color: Colors.white,
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom: 3.0),
              child: Column(
                children: <Widget>[
                  Image.network(
                    val['image'],
                    width: ScreenUtil().setWidth(375),
                  ),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ),
            ));
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text(' ');
    }
  }
}
