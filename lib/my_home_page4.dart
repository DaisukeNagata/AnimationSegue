import 'package:animation_segue/ex_interface.dart';
import 'package:animation_segue/extensions.dart';
import 'package:animation_segue/main.dart';
import 'package:flutter/material.dart';
import 'package:animation_segue/ex_widget.dart';

class MyHomePage4 extends StatefulWidget {
  const MyHomePage4({super.key});

  @override
  State<MyHomePage4> createState() => _MyHomePageState4();
}

class _MyHomePageState4 extends State<MyHomePage4>
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
              segue(const MyHomePage(), '/lib/my_home_page');
            },
            onLongPress: () {
              Navigator.of(context).pop();
            },
            child: const Center(
              child: Text(
                'segue_page4',
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
                x: 0,
                y: (MediaQuery.of(context).size.height - 100) - animation.value,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void segue(Widget w, String path) {
    controller.segue(w, context, path, (_) {
      controller.reverse();
    });
  }
}
