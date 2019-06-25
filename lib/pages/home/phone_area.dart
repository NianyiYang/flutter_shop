import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
