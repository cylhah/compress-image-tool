# 桌面图片压缩工具

这是一款桌面图片压缩工具，使用flutter开发，选择文件夹或者将文件拖入，就可以压缩文件夹中的所有图片，目前支持 jpg 和 png

## 安装依赖

```
flutter packages get
```

## windows 打包命令

```
flutter build windows --dart-define=RunEnv=dist
```

## 自定义的打包命令
可以把windows打包命令打包完的产物添加到压缩包，并读取当前的版本号，输出zip包到dist目录下
```
dart run .\buildScript\build.dart
```