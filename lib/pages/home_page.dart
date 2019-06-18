import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();

  String displayText = '欢迎你xxx';

  @override
  void initState() {
    getHomePageContent().then((val) {
      setState(() {
        displayText = val['data'].toString();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('首页'),
        ),
        body: Center(
          child: Text(displayText),
        ));
  }
}
