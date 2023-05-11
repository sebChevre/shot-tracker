import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:shot_tracker/model/shoot_position.dart';
import 'package:shot_tracker/model/team-stats.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/shoot.dart';
import '../model/shoot_type.dart';

class ShootPositionViewer extends StatelessWidget {
  const ShootPositionViewer(
      {super.key, required this.shcbStat, required this.advStat});

  final TeamStat shcbStat;
  final TeamStat advStat;

  List<Shoot> shoots() {
    List<Shoot> allTeamsShoots = [];

    allTeamsShoots.addAll(shcbStat.shoots);

    allTeamsShoots.addAll(advStat.shoots);

    return allTeamsShoots;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shot Picker',
        home: Scaffold(
            appBar: AppBar(
              leading: BackButton(onPressed: () {
                Navigator.pop(context);
              }),
              title: const Text('SHCB Shots Viewer'),
            ),
            body: Stack(
              children: [
                const Center(
                    child: Image(
                  image: AssetImage('images/piste.png'),
                  //width: 400,
                  //height: 300,
                )),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  //color: Colors.amber,
                  child: CustomPaint(
                    painter: OpenPainter(shcbStat.shoots, advStat.shoots),
                  ),
                ),
              ],
            )));
  }
}

class OpenPainter extends CustomPainter {
  List<Shoot> shcbShoots;
  List<Shoot> advShoots;

  OpenPainter(this.shcbShoots, this.advShoots);

  @override
  void paint(Canvas canvas, Size size) {
    advShoots.forEach((shoot) {
      Color shootColor;

      switch (shoot.shootType) {
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

      var paint1 = Paint()
        ..color = shootColor
        ..strokeWidth = 10;

      //draw points on canvas
      canvas.drawPoints(PointMode.points,
          [Offset(shoot.shootPosition.x, shoot.shootPosition.y)], paint1);
    });

    shcbShoots.forEach((shoot) {
      Color shootColor;

      switch (shoot.shootType) {
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

      var paint1 = Paint()
        ..color = shootColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 10;

      //draw points on canvas
      canvas.drawPoints(PointMode.points,
          [Offset(shoot.shootPosition.x, shoot.shootPosition.y)], paint1);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
