import 'dart:developer';

import 'package:image_compressor/request/res_request.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yaml/yaml.dart';
import 'package:version/version.dart';

class VersionChecker {
  late PackageInfo packageInfo;
  late String serverVersion;

  static late VersionChecker instance;

  VersionChecker(this.packageInfo);

  Future<bool> hasNewVersion() async {
    var serverAppVersion = await getServerAppVersion();
    String buildName = serverAppVersion['buildName'];
    Version severVersion = Version.parse(buildName);
    Version currentVersion = Version.parse(packageInfo.version);

    return severVersion > currentVersion;
  }

  Future<Map> getServerAppVersion() async {
    var res = await resRequestInst.getPubspec();
    var yamlMap = loadYaml(res.data) as Map;
    String version = yamlMap['version'];
    String buildName = version.split('+')[0];
    String buildNumber = version.split('+')[1];
    serverVersion = buildName;
    return {'buildName': buildName, 'buildNumber': buildNumber};
  }
}
