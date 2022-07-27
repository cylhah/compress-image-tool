import 'dart:io';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_compressor/cmd-handler/cmd_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CmdHandler cmdHandler;
  String inputDirPath = '';
  bool hasHandledItem = false;
  bool isSelectDirBtnHover = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DropTarget(
      onDragDone: (details) {
        String dropDPath = details.files[0].path;
        handleFile(dropDPath);
      },
      child: Container(
        color: const Color.fromARGB(255, 44, 45, 49),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: hasHandledItem
                  ? hasHandledItemContent()
                  : noHandledItemContent(),
            ),
            Container(
                height: 40,
                color: const Color.fromARGB(255, 31, 34, 38),
                child: Row(
                  children: [
                    MouseRegion(
                      onEnter: (_) => onSelectDirBtnEnter(true),
                      onExit: (_) => onSelectDirBtnEnter(false),
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onChooseTap,
                        child: Container(
                          margin: const EdgeInsets.only(left: 12),
                          width: 70,
                          height: 22,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: getSelectBtnColor()),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3))),
                          child: Text(
                            '选择文件夹',
                            style: TextStyle(
                                color: getSelectBtnColor(), fontSize: 12),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }

  Column hasHandledItemContent() {
    return Column(children: [
      Container(
        height: 35,
        decoration: const BoxDecoration(color: Color.fromARGB(255, 70, 72, 76)),
      ),
      Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cmdHandler.handleFileList.length,
              itemBuilder: (BuildContext context, int index) {
                FileDataItem fileDataItem = cmdHandler.handleFileList[index];
                bool isInit = fileDataItem.isInit;
                bool isItemOdd = index % 2 == 0;
                Color itemBgColor = isItemOdd
                    ? const Color.fromARGB(255, 39, 41, 45)
                    : const Color.fromARGB(255, 44, 45, 49);
                return Container(
                  height: 70,
                  decoration: BoxDecoration(color: itemBgColor),
                  child: Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Icon(
                        isInit ? Icons.data_usage : Icons.check,
                        color: isInit
                            ? const Color.fromARGB(255, 224, 224, 244)
                            : const Color.fromARGB(255, 115, 212, 89),
                        size: 24.0,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      height: 50,
                      width: 50,
                      child: Image.file(
                        File(fileDataItem.filePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              fileDataItem.fileName,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                          Container(
                            child: fileDataItem.isInit
                                ? const Text(
                                    '正在压缩···',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 127, 127, 127)),
                                  )
                                : Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        fileDataItem.newFileKBStr,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 12, bottom: 2),
                                        child: const Icon(
                                          Icons.arrow_downward,
                                          color:
                                              Color.fromARGB(255, 22, 196, 52),
                                          size: 12.0,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          fileDataItem.reducePercentStr,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                      )
                                    ],
                                  ),
                          )
                        ],
                      ),
                    )
                  ]),
                );
              }))
    ]);
  }

  Column noHandledItemContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
            width: 234, image: AssetImage('assets/images/drag-tip-bg.png')),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text(
            '拖入jpg/png开始压缩\n为你的图片减减肥',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                letterSpacing: 2.0,
                height: 1.5),
          ),
        )
      ],
    );
  }

  void onChooseTap() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      handleFile(selectedDirectory);
    }
  }

  void handleFile(String path) {
    if (!hasHandledItem) {
      cmdHandler = CmdHandler(path);
      setState(() {
        hasHandledItem = true;
      });
    } else {
      setState(() {
        cmdHandler = CmdHandler(path);
      });
    }
    cmdHandler.handleCompressImages(listItemUpdater);
  }

  void listItemUpdater(int index, FileDataItemStatus status, int newFileSize) {
    setState(() {
      cmdHandler.handleFileList[index].status = status;
      cmdHandler.handleFileList[index].newFileSize = newFileSize;
    });
  }

  Color getSelectBtnColor() {
    return isSelectDirBtnHover
        ? const Color.fromARGB(255, 87, 163, 243)
        : const Color.fromARGB(255, 45, 140, 240);
  }

  void onSelectDirBtnEnter(bool isHover) {
    setState(() {
      isSelectDirBtnHover = isHover;
    });
  }
}
