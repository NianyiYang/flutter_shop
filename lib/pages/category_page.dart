import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/config/http_headers.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String displayText = '暂无数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('请求远程数据'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: _chooseAction,
              child: Text('选择完毕'),
            ),
            Text(
              displayText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  /// 处理网络请求
  void _chooseAction() {
    Future future = mockHttp();

    future.then((val) {
      setState(() {
        displayText = val['data'].toString();
      });
    });
  }

  /// 网络请求
  Future mockHttp() async {
    try {
      Dio dio = Dio();
      dio.options.headers = httpHeaders;

      Response response = await dio.get(
        "https://time.geekbang.org/serv/v1/column/newAll",
      );

      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
