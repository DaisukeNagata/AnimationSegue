import 'package:flutter/material.dart';

class ExWidget extends StatelessWidget {
  const ExWidget({
    super.key,
    required this.x,
    required this.y,
  });

  final double x;
  final double y;
  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(x, y, 0),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
