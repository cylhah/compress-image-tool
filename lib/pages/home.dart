import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_compressor/cmd-handler/cmd_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String inputDirPath = '';
  bool isSelectDirBtnHover = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 44, 45, 49),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                      width: 234,
                      image: AssetImage('assets/images/drag-tip-bg.png')),
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
              )),
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
    );
  }

  void onChooseTap() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      CmdHandler.handleCompressDirImages(selectedDirectory);
    }
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
