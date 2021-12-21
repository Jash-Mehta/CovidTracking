import 'package:flutter/material.dart';

class HeightContainer extends StatelessWidget {
  double height;
  Widget ? child;
  HeightContainer({
    Key? key,
    required this.height,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      height: height,
      width: double.infinity,
      child: child,
    );
  }
}
