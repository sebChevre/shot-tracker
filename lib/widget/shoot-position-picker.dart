import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:shot_tracker/model/team-stats.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/shoot.dart';
import '../model/shoot_type.dart';

class _ShootPositionPickerState extends State<ShootPositionPicker> {
  _ShootPositionPickerState(this.setShot, this.isShcbShoot);

  //var points = <Offset>[];
  //TeamStat teamStats;
  List<Offset> points = [];
  final Function setShot;
  final bool isShcbShoot;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.amber,
        child: CustomPaint(
          painter: OpenPainter(points, widget.shootInTrack, widget.isShcbShoot),
        ),
      ),
      GestureDetector(
        child: const Center(
            child: Image(
          image: AssetImage('images/piste.png'),
          //width: 400,
          //height: 300,
        )),
        onTapDown: (details) {
          points = [];
          final tapPosition = details.globalPosition;
          final x = tapPosition.dx;
          final y = tapPosition.dy;
          print("yep ${x} - ${y}");

          setState(() {
            //Shoot shoot = teamStats.shoots.first;
            //shoot.addShootPosition(x, y - 57);
            points.add(Offset(x, y - 57));

            setShot(Offset(x, y - 57));
          });
        },
      )
    ]);
  }
}

class ShootPositionPicker extends StatefulWidget {
  ShootPositionPicker(
      {super.key,
      required this.setShot,
      required Shoot this.shootInTrack,
      required this.isShcbShoot});

  final Function setShot;
  final Shoot shootInTrack;
  final bool isShcbShoot;
  late Offset shootInTrackPosition;

  @override
  State<ShootPositionPicker> createState() =>
      _ShootPositionPickerState(setShot, isShcbShoot);
}

class OpenPainter extends CustomPainter {
  var points;
  Shoot shootInTrack;
  bool isShcbShoot;

  OpenPainter(this.points, this.shootInTrack, this.isShcbShoot);

  @override
  void paint(Canvas canvas, Size size) {
    Color shootColor;

    switch (this.shootInTrack.shootType) {
      case ShootType.sog:
        shootColor = Colors.red;
        break;
      case ShootType.miss:
        shootColor = Colors.orange;
        break;
      case ShootType.block:
        shootColor = Colors.blue;
        break;
      case ShootType.goal:
        shootColor = Colors.green;
        break;
    }

    var pointPaint;

    if (this.isShcbShoot) {
      pointPaint = Paint()
        ..color = shootColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 10;
    } else {
      pointPaint = Paint()
        ..color = shootColor
        ..strokeWidth = 10;
    }

    //draw points on canvas
    canvas.drawPoints(PointMode.points, points, pointPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
