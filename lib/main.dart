import 'package:flutter/material.dart';
import 'package:animation_segue/extensions.dart';
import 'package:animation_segue/my_home_page2.dart';
import 'package:animation_segue/ex_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  GlobalKey key = GlobalKey();

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
          end: MediaQuery.of(context).size.width - 100.0,
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
              _segue();
            },
            child: const Center(
              child: Text(
                'segue_page1',
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
                x: animation.value,
                y: 0,
              );
            },
          ),
        ],
      ),
    );
  }

  void _segue() {
    controller.segue(const MyHomePage2(), context, '/lib/my_home_page2',
        (path) {
      if (path == '/lib/my_home_page2') {
        controller.reverse();
      }
    });
  }
}
