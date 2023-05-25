import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_math/vector_math.dart' as math;

import '../model/shoot.dart';
import '../model/shoot_type.dart';

class _ShootPositionPickerState extends State<ShootPositionPicker> {
  _ShootPositionPickerState(this.shootInTrack);

  final GlobalKey _pisteImageKey = GlobalKey();

  List<Offset> _shootPoints = [];

  //final bool isShcbShoot;
  final Shoot shootInTrack;
  bool pisteRendering = false;
  late Offset pisteOffset;
  late Size pisteSize;

  @override
  void initState() {
    super.initState();
  }

  _isLandingScreen() {
    return (MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height) >
        1;
  }

  _update(context) {
    print("init");
    setState(() {});
  }

  Offset? _getOffset(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    Offset? position2 = box?.globalToLocal(Offset.zero);

    if (position != null) {
      print("image : x:${position.dx},y:${position.dy}");
      print("image : x:${position2!.dx},y:${position2.dy}");
      print("Taille: ${box!.size.width}, ${box.size.height}");
      return position;
    }
  }

  Future<void> _runsAfterBuild() async {
    if (!pisteRendering) {
      await Future.delayed(
          Duration(milliseconds: 100)); // <-- Add a 0 dummy waiting time
      // This code runs after build ...

      setState(() {
        pisteOffset = _getOffset(_pisteImageKey)!;
        pisteSize = _getPisteSize(_pisteImageKey)!;
        pisteRendering = true;
      });
    }
  }

  Size? _getPisteSize(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Size? size = box?.size;

    if (size != null) {
      return size;
    }
  }

  @override
  Widget build(BuildContext context) {
    _runsAfterBuild();
    //dimensions écrans
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("Taille widget: ${width}, ${height}");
    double angle = _isLandingScreen() ? 90 : 0;
    return Stack(children: [
      Container(
        //height: height,

        child: CustomPaint(
          painter: OpenPainter(
              _getOffset(_pisteImageKey), _shootPoints, shootInTrack),
        ),
      ),
      Container(
          //height: height,

          child: pisteRendering
              ? CustomPaint(
                  painter: TextTeamsPainter(pisteSize),
                )
              : Container()),
      GestureDetector(
        child: SvgPicture.asset(
          'images/piste.svg',
          key: _pisteImageKey,
          height: height,
          fit: BoxFit.fill,
          //width: width,
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
  ShootPositionPicker({super.key, required this.shootInTrack});

  final Shoot shootInTrack;
  //late Offset shootInTrackPosition;

  @override
  State<ShootPositionPicker> createState() =>
      _ShootPositionPickerState(shootInTrack);
}

class TextTeamsPainter extends CustomPainter {
  TextTeamsPainter(this.pisteSize);

  Size? pisteSize;
  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    final textSpan = TextSpan(
      text: 'Hello, world.',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: pisteSize!.width,
    );

    print(pisteSize!.width);
    final xCenter = 0;
    const yCenter = 0;
    final offset = Offset(xCenter as double, yCenter as double);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
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
