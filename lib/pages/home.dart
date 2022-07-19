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
            Expanded(flex: 1, child: Container()),
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
