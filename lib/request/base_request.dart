import 'package:dio/dio.dart';

class BaseRequest {
  late Dio dioInst;

  BaseRequest(String baseUrl) {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl, connectTimeout: 10000, receiveTimeout: 10000);
    dioInst = Dio(options);
    dioInst.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }));
  }

  void handleCodeError(int code, String message) {}

  Future<Response> sendRequest(String path, String method, {dynamic data}) {
    return dioInst.request(path, options: Options(method: method), data: data);
  }
}
