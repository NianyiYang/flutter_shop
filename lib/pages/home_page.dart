import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';

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
            String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];

            //楼层商品和图片
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            List<Map> floor3 = (data['data']['floor3'] as List).cast();

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SwiperDiy(swiperList: swiperDataList),
                  TopNavigator(navList: navDataList),
                  AdBanner(adResource: adResource),
                  Phone(phoneResource: phoneResource, phoneNumber: phoneNumber),
                  Recommend(recommendList: recommendList),
                  Floor(imageUrl: floor1Title,floorItemList: floor1),
                  Floor(imageUrl: floor2Title,floorItemList: floor2),
                  Floor(imageUrl: floor3Title,floorItemList: floor3),
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
