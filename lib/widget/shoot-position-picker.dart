import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shot_tracker/model/match.dart';
import '../model/match.dart' as match_lib;

import '../model/shoot.dart';
import '../model/shoot_type.dart';
import '../painter/team_text_painter.dart';

class _ShootPositionPickerState extends State<ShootPositionPicker> {
  _ShootPositionPickerState({required this.shootInTrack, required this.match});

  final GlobalKey _pisteImageKey = GlobalKey();

  List<Offset> _shootPoints = [];

  //final bool isShcbShoot;
  final Shoot shootInTrack;
  final match_lib.Match match;
  bool pisteRendering = false;
  late Offset pisteOffset;
  late Size pisteSize;

  @override
  void initState() {
    super.initState();
  }

  Offset? _getOffset(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    Offset? position2 = box?.globalToLocal(Offset.zero);

    if (position != null) {
      return position;
    }
  }

  Size? _getPisteSize(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Size? size = box?.size;

    if (size != null) {
      return size;
    }
  }

  void _postFrameCallback(_) {
    setState(() {
      pisteOffset = _getOffset(_pisteImageKey)!;
      pisteSize = _getPisteSize(_pisteImageKey)!;
      pisteRendering = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(_postFrameCallback);
    //_runsAfterBuild();
    //dimensions écrans
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("Taille widget: ${width}, ${height}");

    return Stack(children: [
      Container(
        //height: height,

        child: CustomPaint(
          painter: OpenPainter(
              _getOffset(_pisteImageKey), _shootPoints, shootInTrack),
        ),
      ),
      Container(
          child: pisteRendering
              ? CustomPaint(
                  painter: TextTeamsPainter(pisteSize: pisteSize, match: match),
                )
              : Container()),
      GestureDetector(
        child: SvgPicture.asset(
          'images/piste.svg',
          key: _pisteImageKey,
          height: height,
          fit: BoxFit.fill,
          width: width,
          //alignment: Alignment.topCenter
        ),
        onTapDown: (details) {
          _shootPoints = [];

          final localTapPosition = details.localPosition;

          final x = localTapPosition.dx;
          final y = localTapPosition.dy;
          print("Click [local] ${x} - ${y}");

          final globalTapPosition = details.globalPosition;
          final xg = globalTapPosition.dx;
          final yg = globalTapPosition.dy;
          print("Click [global] ${xg} - ${yg}");

          setState(() {
            //Shoot shoot = teamStats.shoots.first;
            //shoot.addShootPosition(x, y - 57);
            Offset? pisteOffset = _getOffset(_pisteImageKey);
            _shootPoints.add(Offset(x, y));

            print(
                "shhot picked: x:${x / _getPisteSize(_pisteImageKey)!.width}, y: ${y / _getPisteSize(_pisteImageKey)!.height}");
            shootInTrack.addShootPosition(
                x / _getPisteSize(_pisteImageKey)!.width,
                y / _getPisteSize(_pisteImageKey)!.height);

            //setShot(Offset(x, y));
          });
        },
      ),
    ]);
  }
}

class ShootPositionPicker extends StatefulWidget {
  ShootPositionPicker(
      {super.key, required this.shootInTrack, required this.match});

  final Shoot shootInTrack;
  final Match match;
  //late Offset shootInTrackPosition;

  @override
  State<ShootPositionPicker> createState() =>
      _ShootPositionPickerState(shootInTrack: shootInTrack, match: match);
}

class OpenPainter extends CustomPainter {
  List<Offset> points;
  Shoot shootInTrack;
  //bool isShcbShoot;
  Offset? pisteOffset;

  OpenPainter(this.pisteOffset, this.points, this.shootInTrack);

  @override
  void paint(Canvas canvas, Size size) {
    Color shootColor;
    //size.center(pisteOffset!);
    print("Canvas size: ${size.height}:${size.width}");

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

    /**
     * if (this.isShcbShoot) {
      pointPaint = Paint()
        ..color = shootColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 10;
    } else {
      pointPaint = Paint()
        ..color = shootColor
        ..strokeWidth = 10;
    }
*/
    pointPaint = Paint()
      ..color = shootColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;
    //draw points on canvas

    var pointsToRender = points.map((point) {
      return Offset(point.dx, point.dy);
    }).toList();
    canvas.drawPoints(PointMode.points, pointsToRender, pointPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
