import 'package:flutter/material.dart';

/// 广告组件
class AdBanner extends StatelessWidget {
  final String adResource;

  AdBanner({Key key, this.adResource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('广告组件');
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      color: Colors.white,
      child: Image.network(adResource),
    );
  }
}
