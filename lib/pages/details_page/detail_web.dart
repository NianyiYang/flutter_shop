import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetail = Provide.value<DetailsInfoProvide>(context)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;
    var goodsComments =
        Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodComments;
    return Provide<DetailsInfoProvide>(
      builder: (context, child, value) {
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;

        if (isLeft) {
          return Container(
            child: Html(data: goodsDetail),
          );
        } else {
          return DetailsComments(goodsComments);
        }
      },
    );
  }
}

class DetailsComments extends StatelessWidget {
  final List<GoodComments> comments;

  DetailsComments(this.comments);

  @override
  Widget build(BuildContext context) {
    if (comments.isNotEmpty) {
      return ListView.builder(
        // TODO 解决 Vertical viewport was given unbounded height
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _commentItem(comments[index]);
        },
        itemCount: comments.length,
      );
    } else {
      return Container(
          width: ScreenUtil().setWidth(750),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text('暂时没有数据'));
    }
  }

  Widget _commentItem(GoodComments comment) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('评分：${comment.sCORE}'),
            Text('评论：${comment.comments}'),
          ],
        ),
      ),
    );
  }
}
