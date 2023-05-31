import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shot_tracker/widget/ui_constants.dart';

import '../model/shoot.dart';

class ShootPointPainter extends CustomPainter {
  List<Offset> points;
  Shoot shootInTrack;
  Offset? pisteOffset;

  ShootPointPainter(this.pisteOffset, this.points, this.shootInTrack);

  @override
  void paint(Canvas canvas, Size size) {
    Color shootColor = UiConstants.colorForShot(shootInTrack);

    Paint pointPaint = Paint()
      ..color = shootColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    var pointsToRender = points.map((point) {
      return Offset(point.dx, point.dy);
    }).toList();
    canvas.drawPoints(PointMode.points, pointsToRender, pointPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
