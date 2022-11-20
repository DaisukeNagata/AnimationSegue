import 'package:animation_segue/ex_interface.dart';
import 'package:flutter/material.dart';
import 'package:animation_segue/ex_extensions.dart';
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
      home: MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String? title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
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
              segue(const MyHomePage2(), '/lib/my_home_page2');
            },
            onLongPress: () {
              if (widget.title?.isNotEmpty ?? false) {
                Navigator.of(context).pop();
              }
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

  @override
  void segue(Widget w, String path) {
    controller.segue(w, context, path, () {
      controller.reverse();
    });
  }
}
