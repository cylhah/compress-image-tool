import 'package:image_compressor/common/env_handler.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class CmdHandler {
  String inputFilePath = '';
  List<String> inputFilePaths = [];
  List<FileDataItem> handleFileList = [];

  CmdHandler(this.inputFilePaths) {
    for (var i = 0; i < inputFilePaths.length; i++) {
      String item = inputFilePaths[i];
      handleFilePath(item);
    }
  }

  handleFilePath(String inputPath) {
    var type = FileSystemEntity.typeSync(inputPath);
    if (type == FileSystemEntityType.directory) {
      var dir = Directory(inputPath);
      var entities = dir.listSync();
      for (var i = 0; i < entities.length; i++) {
        var item = entities[i];
        if (item is File) {
          checkAddFileToList(item);
        }
      }
    } else if (type == FileSystemEntityType.file) {
      File item = File(inputPath);
      checkAddFileToList(item);
    }
  }

  void checkAddFileToList(File file) {
    String filePath = file.path;
    String ext = p.extension(filePath).toLowerCase();
    if (ext == '.png' || ext == '.jpg') {
      int fileSize = file.lengthSync();
      FileDataItem fileDataItem = FileDataItem(filePath, fileSize);
      handleFileList.add(fileDataItem);
    }
  }

  String getExePath(String exeName) {
    if (EnvHandler.isLocal()) {
      return p.normalize(p.join(p.current, './assets/exes/$exeName.exe'));
    } else {
      return p.normalize(
          p.join(p.current, './data/flutter_assets/assets/exes/$exeName.exe'));
    }
  }

  String getJpgCompressExePath() {
    return getExePath('jpeg-recompress');
  }

  String getPngCompressExePath() {
    return getExePath('pngquant');
  }

  void handleCompressImages(Function stateUpdateCB) {
    String jpgCompressExePath = getJpgCompressExePath();
    String pngCompressExePath = getPngCompressExePath();

    for (var i = 0; i < handleFileList.length; i++) {
      var item = handleFileList[i];
      String filePath = item.filePath;
      String fileExt = item.fileExt;
      if (fileExt == '.png') {
        Process.run(pngCompressExePath, [
          '--quality=65-80',
          filePath,
          '--ext=.png',
          '--force'
        ]).then((value) {
          File ouput = File(filePath);
          var newSize = ouput.lengthSync();
          stateUpdateCB(i, FileDataItemStatus.processSuccess, newSize);
        });
      } else if (fileExt == '.jpg') {
        Process.run(jpgCompressExePath, [
          '--quality',
          'high',
          '--min',
          '60',
          filePath,
          filePath
        ]).then((value) {
          File ouput = File(filePath);
          var newSize = ouput.lengthSync();
          stateUpdateCB(i, FileDataItemStatus.processSuccess, newSize);
        });
        ;
      }
    }
  }
}

enum FileDataItemStatus { init, processSuccess, processError }

class FileDataItem {
  String filePath = '';
  int origionFileSize = 0;
  int newFileSize = 0;
  FileDataItemStatus status = FileDataItemStatus.init;

  FileDataItem(this.filePath, this.origionFileSize);

  String get fileName {
    return p.basename(filePath);
  }

  String calcFileByteStr(int size) {
    double res = size / 1024;
    return res.toStringAsFixed(1);
  }

  String get fileExt {
    return p.extension(filePath).toLowerCase();
  }

  String get newFileKBStr {
    String res = calcFileByteStr(newFileSize);
    return '${res}KB';
  }

  String get reducePercentStr {
    double percent = (newFileSize - origionFileSize) / origionFileSize * 100;
    percent = percent.abs();
    return '${percent.toStringAsFixed(0)}%';
  }

  bool get isInit {
    return status == FileDataItemStatus.init;
  }
}
