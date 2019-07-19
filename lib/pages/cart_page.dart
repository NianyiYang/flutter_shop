import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 500.0,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(testList[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              _add();
            },
            child: Text('增加'),
          ),
          RaisedButton(
            onPressed: () {
              _clear();
            },
            child: Text('清空'),
          ),
        ],
      ),
    );
  }

  void _add() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String temp = "随便写";

    testList.add(temp);
    sp.setStringList('testInfo', testList);
    _show();
  }

  void _show() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      if (sp.getStringList('testInfo') != null) {
        testList = sp.getStringList('testInfo');
      }
    });
  }

  void _clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    //prefs.clear(); //全部清空
    sp.remove('testInfo'); //删除key键
    setState(() {
      testList = [];
    });
  }
}
