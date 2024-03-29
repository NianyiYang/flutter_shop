import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

import 'category/right_nav.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  String displayText = '暂无数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// 分类左侧导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    // 点击状态
    bool isClicked = false;
    isClicked = (index == listIndex) ? true : false;

    return InkWell(
      onTap: () {
        // 修改点击状态
        setState(() {
          listIndex = index;
        });
        // 修改状态
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);

        // TODO 请求小类，因为模拟接口所以没有入参
        _getGoodList();
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
          color: isClicked ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  /// 处理网络请求
  void _getCategory() async {
    await request('getCategory').then((value) {
      var data = value;
      print(data);
      CategoryModel categoryModel = CategoryModel.fromJson(data);

      setState(() {
        list = categoryModel.data;
      });

      // 初始化小磊数据
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto);
    });
  }

  /// TODO 搬到这里
  void _getGoodList() async {
    await request('getMallGoods').then((value) {
      var data = value;
      print(data);
      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(model.data);
    });
  }
}

/// 商品列表页
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  var scrollController = new ScrollController();

  // refresh footer
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        // TODO 每次切换大类的时候返回第一项
        try {
          if (Provide.value<ChildCategory>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化：${e}');
        }

        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                moreInfo: '加载中',
                loadReadyText: '上拉加载',
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: data.goodsList.length,
                itemBuilder: (context, index) {
                  return _listWidget(data.goodsList, index);
                },
              ),
              loadMore: () async {
                _getMore();
              },
            ),
          ),
        );
      },
    );
  }

  // TODO 模拟接口 没法分页
  void _getMore() {
    Provide.value<ChildCategory>(context).addPage();

//    var data={
//      'categoryId':Provide.value<ChildCategory>(context).categoryId,
//      'categorySubId':Provide.value<ChildCategory>(context).subId,
//      'page':Provide.value<ChildCategory>(context).page
//    };

//    request('getMallGoods').then((value) {
//      var data = value;
//      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
//      Provide.value<CategoryGoodsListProvide>(context).addGoodsList(goodsList.data);
//
//    });
    Provide.value<ChildCategory>(context).changeNoMore('没有更多了');

    // TODO toast test
    Fluttertoast.showToast(
      msg: "已经到底了",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.pink,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// 商品图片
  Widget _goodsImage(List<CategoryListData> list, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  /// 商品名称
  Widget _goodsName(List<CategoryListData> list, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  /// 商品价格
  Widget _goodsPrice(List<CategoryListData> list, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${list[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(28),
            ),
          ),
          Text(
            '￥${list[index].oriPrice}',
            style: TextStyle(
              color: Colors.black12,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  /// 将上面三项组合
  Widget _listWidget(List<CategoryListData> list, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(list, index),
            Column(
              children: <Widget>[
                _goodsName(list, index),
                _goodsPrice(list, index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
