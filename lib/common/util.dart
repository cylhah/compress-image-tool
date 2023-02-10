import 'package:path/path.dart' as p;
import 'package:image_compressor/common/env_handler.dart';

String getExeFilePath(String exeName) {
  if (EnvHandler.isLocal()) {
    return p.normalize(p.join(p.current, './assets/exes/$exeName.exe'));
  } else {
    return p.normalize(
        p.join(p.current, './data/flutter_assets/assets/exes/$exeName.exe'));
  }
}

String getAppResPath(String version) {
  return 'https://github.com/cylhah/compress-image-tool/releases/download/release-$version/image-compress-$version.zip';
}
