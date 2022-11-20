import 'package:flutter/material.dart';
import 'package:animation_segue/ex_widget.dart';

class MyHomePage2 extends StatelessWidget {
  const MyHomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Material(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'segue_page2',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const ExWidget(
            x: 0,
            y: 0,
          ),
        ],
      ),
    );
  }
}
