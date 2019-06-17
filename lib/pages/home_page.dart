import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();

  String displayText = '欢迎你xxx';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '类型',
                helperText: '请选择类型',
              ),
              autofocus: false,
            ),
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
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text('不能选择空')));
      return;
    }

    Future future = mockHttp(typeController.text.toString());

    future.then((val) {
      setState(() {
        displayText = val['data']['name'].toString();
      });
    });
  }

  /// 网络请求
  Future mockHttp(String name) async {
    try {
      Response response = await Dio().get(
          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
          queryParameters: {'name': name});

      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}

//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    mockHttp();
//
//    return Scaffold(
//      body: Center(
//        child: Text('首页'),
//      ),
//    );
//  }
//
//  void mockHttp() async {
//    try {
//      Response response = await Dio().get(
//          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
//          queryParameters: {'name': 'JJ'});
//
//      return print(response);
//    } catch (e) {
//      return print(e);
//    }
//  }
//}
