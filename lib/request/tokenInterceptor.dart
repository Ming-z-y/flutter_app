import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/login.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/request/base_config.dart';
import 'package:flutter_application_1/request/httpUtil.dart';
import 'package:flutter_application_1/utils/cache.dart';

class RefreshTokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String token = AppCache.token ?? '';
    options.headers['Authorization'] = 'Bearer ' + token;
    super.onRequest(options, handler);
  }

  // @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data["status"] == 10005) {
      Dio dio = HttpUtil.getDio();
      String token = await getNewToken();
      if (token != '') {
        await AppCache.setToken(token);
        var request = response.requestOptions;
        try {
          var res = await dio.request(
            request.path,
            data: request.data,
            queryParameters: request.queryParameters,
            cancelToken: request.cancelToken,
            options: Options(
              method: request.method,
              headers: {
                "Authorization": "Bearer $token",
              },
              contentType: 'application/json',
            ),
            onReceiveProgress: request.onReceiveProgress,
          );
          // super.onResponse(response, handler);
          handler.next(response);
        } on DioError catch (e) {
          print(e);
        }
      } else {
        final context = MyApp.navigatorKey.currentContext;
        // 跳转登录页面
        await Navigator.pushReplacement(
          context!,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } else {
      handler.next(response);
    }
  }
}

Future<String> getNewToken() async {
  String refresh_token = AppCache.refresh_token ?? '';
  String token = '';
  Dio dio = Dio();
  dio.options.baseUrl = BASE_Config.BASE_URL;
  dio.options.headers['Authorization'] = 'Bearer ' + refresh_token;
  try {
    var res = await dio.get('/user/token');
    if (res.data['status'] == 10001) {
      token = res.data['access_token'];
    } else {
      token = '';
    }
  } catch (e) {}
  return token;
}
