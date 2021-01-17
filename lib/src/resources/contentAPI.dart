import 'package:beanknowledge/config/host_config.dart';
import 'package:dio/dio.dart';

//这个类会被UI用来调用服务器端的api获得数据，所以应具备get/post等方法
class ContentAPI {
  final String _baseURL = Config.domain;
  //定义get方法
  dynamic get(String url) async {
    var responseJson;
    try {
      final response = await Dio().get(_baseURL + url);
      //_handleResponseByStatuscod方法会根据不同的status code给出不同的提示
      responseJson = _handleResponseByStatuscode(response);
    } catch (e) {
      throw Exception('Error occured receiving data from server: $e');
    }
    return responseJson;
  }

  dynamic _handleResponseByStatuscode(Response response) {
    switch (response.statusCode) {
      //200是返回数据成功的code，其他code也可以这样定义，根据不同code可以反馈不同的信息给开发者或者用户
      case 200:
        return response.data;
      default:
        throw Exception(
            'Error occured communicating with server with status code:${response.statusCode}');
    }
  }
}
