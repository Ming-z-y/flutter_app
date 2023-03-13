import 'package:dio/dio.dart';
import './base_config.dart';
import 'dart:convert' show json;

class HttpUtil {
  static HttpUtil instance = HttpUtil._internal();
  Dio? _dio;
  late BaseOptions options;
  factory HttpUtil() => instance;

  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    if (_dio == null) {
      options = BaseOptions(
        baseUrl: BASE_Config.BASE_URL,
        connectTimeout: BASE_Config.CONNECT_TIMEOUT,
        receiveTimeout: BASE_Config.RECEIVE_TIMEOUT,
        responseType: ResponseType.json,
      );
      _dio = Dio(options);
    }
  }

  Future get(url, {data, options, cancelToken}) async {
    try {
      Response response = await _dio!.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      return response.data;
    } on DioError catch (e) {
      formatError(e);
      return;
    }
  }

  /*
   * post请求
   */
  Future post(url, {data, options, cancelToken}) async {
    try {
      Response response = await _dio!.post(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      return json.decode(response.toString());
    } on DioError catch (e) {
      formatError(e);
      return;
    }
  }

  // /*
  //  * 下载文件
  //  */
  // downloadFile(urlPath, savePath) async {
  //   Response response;
  //   try {
  //     response = await dio.download(urlPath, savePath,
  //         onReceiveProgress: (int count, int total) {
  //       //进度
  //       print("$count $total");
  //     });
  //     print('downloadFile success---------${response.data}');
  //   } on DioError catch (e) {
  //     print('downloadFile error---------$e');
  //     formatError(e);
  //   }
  //   return response.data;
  // }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    print('e.response.statusCode');
    print(e.response?.statusCode);
    if (e.type == DioErrorType.connectTimeout) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.response) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }
}
