import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:archive/archive_io.dart';
import 'package:yaml/yaml.dart';
import 'dart:io';

void main() async {
  print('build start');

  var res2 = await Process.run(
      'fvm', ['flutter', 'build', 'windows', '--dart-define=RunEnv=dist'],
      stdoutEncoding: const Utf8Codec());
  print('build info:${res2.stdout}');

  var yamlStr = File(p.join(p.current, 'pubspec.yaml')).readAsStringSync();
  var yamlMap = loadYaml(yamlStr) as Map;
  String version = yamlMap['version'];
  version = version.split('+')[0];
  print('read version: $version');

  var buildDir = p.join(p.current, 'build', 'windows', 'runner', 'Release');
  var zipToPath = p.join(p.current, 'dist', 'image-compress-$version.zip');
  var encoder = ZipFileEncoder();
  encoder.zipDirectory(Directory(buildDir), filename: zipToPath);
  print('output build zip: $zipToPath');

  print('build end');
}
