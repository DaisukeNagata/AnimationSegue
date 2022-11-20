import 'package:flutter/widgets.dart';

extension GlobalKeyEx on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}

extension Transition on AnimationController {
  AnimationController segue(
    Widget w,
    BuildContext context,
    String path,
    Function(String) callback,
  ) {
    forward().whenComplete(() {
      Navigator.push(
        context,
        PageRouteBuilder<void>(
          settings: RouteSettings(name: path),
          pageBuilder: (context, animation, secondaryAnimation) => w,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (animation.isCompleted) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            } else {
              return Container();
            }
          },
        ),
      ).then(
        (_) => callback(path),
      );
    });
    return this;
  }
}
