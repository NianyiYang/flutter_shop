import 'package:dio/dio.dart';

Future getHomePageContent() async {
  try {
    Response response = await Dio().get(
        "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
        queryParameters: {'name': name});

    return response.data;
  } catch (e) {
    return print(e);
  }
}