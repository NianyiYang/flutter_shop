import 'package:dio/dio.dart';
import 'package:flutter_shop/config/service_url.dart';

Future getHomePageContent() async {
  try {
    Response response = await Dio().get(
      servicePath['homePageContent'],
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print(e);
  }
}
