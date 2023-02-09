import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:image_compressor/request/base_request.dart';

class MyRequest extends BaseRequest {
  MyRequest(super.baseUrl);

  Future<Response> getPubspec() {
    return sendRequest(
        'https://raw.githubusercontent.com/cylhah/compress-image-tool/master/pubspec.yaml',
        'GET');
  }

  @override
  void handleCodeError(int code, String message) {
    super.handleCodeError(code, message);
    log('handleCodeError code: $code, message: $message');
  }
}

MyRequest myRequestInst = MyRequest('');
