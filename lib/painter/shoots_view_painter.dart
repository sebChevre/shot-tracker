import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

import '../model/shoot.dart';
import '../widget/ui_constants.dart';

class ShootsViewPainter extends CustomPainter {
  List<Shoot> residentShoot;
  List<Shoot> visiteurShoot;
  Size? pisteSize;
  Offset? pisteOffset;

  ShootsViewPainter(
      this.residentShoot, this.visiteurShoot, this.pisteSize, this.pisteOffset);

  @override
  void paint(Canvas canvas, Size size) {
    //shoots adverses
    for (Shoot shoot in visiteurShoot) {
      drawShoot(canvas, shoot);
    }

    //shoot locaux
    for (var shoot in residentShoot) {
      drawBorderShoot(canvas, shoot);
      drawShoot(canvas, shoot);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void drawShoot(Canvas canvas, Shoot shoot) {
    Color shootColor = UiConstants.colorForShot(shoot);
    Paint paint = Paint()..color = shootColor;

    canvas.drawCircle(
        Offset((shoot.shootPosition.x * pisteSize!.width),
            (shoot.shootPosition.y * pisteSize!.height)),
        5,
        paint);
  }

  void drawBorderShoot(Canvas canvas, Shoot shoot) {
    Paint paint = Paint()..color = Colors.black;
    canvas.drawCircle(
        Offset((shoot.shootPosition.x * pisteSize!.width),
            (shoot.shootPosition.y * pisteSize!.height)),
        7,
        paint);
  }
}
