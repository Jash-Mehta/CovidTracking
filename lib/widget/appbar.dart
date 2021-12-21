import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartingBar extends StatefulWidget {
  const StartingBar({Key? key}) : super(key: key);

  @override
  State<StartingBar> createState() => _StartingBar();
}

class _StartingBar extends State<StartingBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text(
          "Booking Request",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )));
  }
}
