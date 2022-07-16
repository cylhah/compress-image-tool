import 'package:image_compressor/common/env_handler.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class CmdHandler {
  static String getExePath(String exeName) {
    if (EnvHandler.isLocal()) {
      return p.normalize(p.join(p.current, './assets/exes/$exeName.exe'));
    } else {
      return p.normalize(
          p.join(p.current, './data/flutter_assets/assets/exes/$exeName.exe'));
    }
  }

  static String getJpgCompressExePath() {
    return CmdHandler.getExePath('jpeg-recompress');
  }

  static String getPngCompressExePath() {
    return CmdHandler.getExePath('pngquant');
  }

  static void handleCompressDirImages(String inputDirPath) async {
    String jpgCompressExePath = CmdHandler.getJpgCompressExePath();
    String pngCompressExePath = CmdHandler.getPngCompressExePath();

    var dir = Directory(inputDirPath);
    var files = dir.listSync();
    for (var i = 0; i < files.length; i++) {
      var item = files[i];
      String filePath = item.path;
      String ext = p.extension(filePath).toLowerCase();
      if (ext == '.png') {
        Process.run(pngCompressExePath,
            ['--quality=65-80', filePath, '--ext=.png', '--force']);
      } else if (ext == '.jpg') {
        Process.run(jpgCompressExePath,
            ['--quality', 'high', '--min', '60', filePath, filePath]);
      }
    }
  }
}
