import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:image_compressor/request/base_request.dart';

class ResRequest extends BaseRequest {
  ResRequest(super.baseUrl);

  Future<Response> getPubspec() {
    return sendRequest(
        'https://raw.githubusercontent.com/cylhah/compress-image-tool/master/pubspec.yaml',
        'GET');
  }

  Future<Response> downloadServerApp(String version, Function progressCB) {
    return dioInst.download(
        'https://github.com/cylhah/compress-image-tool/releases/download/release-$version/image-compress-$version.zip',
        './dist/test.zip', onReceiveProgress: (received, total) {
      var progress = (received / total) * 100;
      log('progress: $progress');
      progressCB(received / total);
    });
  }

  @override
  void handleCodeError(int code, String message) {
    super.handleCodeError(code, message);
    log('handleCodeError code: $code, message: $message');
  }
}

ResRequest resRequestInst = ResRequest('');
