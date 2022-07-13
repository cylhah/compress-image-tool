import 'dart:developer';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 45, 140, 240)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3))),
                          child: const Text(
                            '选择文件夹',
                            style: TextStyle(
                                color: Color.fromARGB(255, 45, 140, 240),
                                fontSize: 12),
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

  void onChooseTap() {
    log('message');
  }
}
