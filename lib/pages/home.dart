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
            )
          ],
        ),
      ),
    );
  }
}
