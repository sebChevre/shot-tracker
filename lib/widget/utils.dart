import 'package:flutter/widgets.dart';

class Utils {
  static Offset? getPisteOffset(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);

    if (position != null) {
      return position;
    }
  }

  static Size? getPisteSize(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Size? size = box?.size;

    if (size != null) {
      return size;
    }
  }
}
