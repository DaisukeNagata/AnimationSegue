import 'package:animation_segue/ex_interface.dart';
import 'package:animation_segue/ex_extensions.dart';
import 'package:animation_segue/my_home_page3.dart';
import 'package:flutter/material.dart';
import 'package:animation_segue/ex_widget.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key});

  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2>
    with TickerProviderStateMixin
    implements ExInterFace {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(controller);
    animation.addListener(() {
      if (controller.isAnimating) {
        animation = Tween<double>(
          begin: 0,
          end: MediaQuery.of(context).size.height - 100.0,
        ).chain(CurveTween(curve: Curves.easeInOut)).animate(controller);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          TextButton(
            onPressed: () {
              segue(const MyHomePage3(), '/lib/my_home_page3');
            },
            onLongPress: () {
              Navigator.of(context).pop();
            },
            child: const Center(
              child: Text(
                'segue_page2',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return ExWidget(
                x: MediaQuery.of(context).size.width - 100,
                y: animation.value,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void segue(Widget w, String path) {
    controller.segue(w, context, path, () {
      controller.reverse();
    });
  }
}
