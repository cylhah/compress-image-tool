import 'package:flutter/material.dart';
import 'package:image_compressor/common/version_checker.dart';
import 'package:image_compressor/pages/app.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
      size: Size(400, 650), title: '图片压缩工具', minimumSize: Size(400, 650));
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  PackageInfo.fromPlatform().then((value) {
    VersionChecker.instance = VersionChecker(value);
  });
  runApp(const MyApp());
}
