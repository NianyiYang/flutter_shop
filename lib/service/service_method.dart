import 'package:dio/dio.dart';
import 'package:flutter_shop/config/service_url.dart';

Future getHomePageContent() async {
  try {
    Response response = await Dio().get(
      servicePath['homePageContent'],
      options: Options(
        responseType: ResponseType.json,
      ),
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

Future getHomePageBelowContent(int page) async {
  try {
    Response response = await Dio().post(
      servicePath['homePageBelowContent'],
      data: page,
      options: Options(
        responseType: ResponseType.json,
      ),
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

/// 所谓的通用接口
Future request(url, {formData}) async {
  try {
    print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    // TODO 模拟接口不要 post
//    if (formData == null) {
//      response = await dio.post(servicePath[url]);
//    } else {
//      response = await dio.post(servicePath[url], data: formData);
//    }
    response = await dio.get(servicePath[url]);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print(e);
  }
}
