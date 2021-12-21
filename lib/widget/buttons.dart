import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  VoidCallback? onpressed;
  String? text;
  double height;
  IconData? icon;
  double width;
  Buttons({
    Key? key,
    required this.onpressed,
    this.text,
    required this.height,
    required this.width,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(10.0),
          shadowColor: MaterialStateProperty.all<Color>(Colors.black87),
          side: MaterialStateProperty.all(
              const BorderSide(color: Colors.black, width: 1.5)),
          backgroundColor: MaterialStateProperty.all(Colors.white)),
      onPressed: onpressed,
      child: SizedBox(
        height: height,
        width: width,
        child: Row(children: [
          Center(
              child: Text(
            text!,
            style: TextStyle(color: Colors.black),
          )),
          Center(
              child: Icon(
            icon,
            color: Colors.green[500],
            size: 25.0,
          ))
        ]),
      ),
    );
  }
}
