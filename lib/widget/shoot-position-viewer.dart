import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:shot_tracker/model/shoot_position.dart';
import 'package:shot_tracker/model/team-stats.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../model/shoot.dart';
import '../model/shoot_type.dart';
import '../model/match.dart' as match_lib;

class ShootPositionViewer extends StatefulWidget {
  ShootPositionViewer({super.key, required this.match});

  final match_lib.Match match;

  @override
  State<ShootPositionViewer> createState() =>
      _ShootPositionViewerState(match: match);
}

class _ShootPositionViewerState extends State<ShootPositionViewer>
    with WidgetsBindingObserver {
  _ShootPositionViewerState({required this.match});

  final match_lib.Match match;
  bool pisteRendering = false;
  late Offset pisteOffset;
  late Size pisteSize;

  final GlobalKey _pisteImageKey = GlobalKey();

  List<Shoot> shoots() {
    List<Shoot> allTeamsShoots = [];

    allTeamsShoots.addAll(match.getResidentstats().shoots);

    allTeamsShoots.addAll(match.getVisiteurStats().shoots);

    return allTeamsShoots;
  }

  Future<void> _runsAfterBuild() async {
    print("run after build...");
    if (!pisteRendering) {
      await Future.delayed(
          Duration(milliseconds: 0)); // <-- Add a 0 dummy waiting time
      // This code runs after build ...

      setState(() {
        pisteOffset = _getPisteOffset(_pisteImageKey)!;
        pisteSize = _getPisteSize(_pisteImageKey)!;
        pisteRendering = true;
      });
    }
  }

  Offset? _getPisteOffset(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    Offset? position2 = box?.globalToLocal(Offset.zero);

    print("offset...");

    if (position != null) {
      print("image : x:${position.dx},y:${position.dy}");
      print("image : x:${position2!.dx},y:${position2.dy}");
      print("Taille: ${box!.size.width}, ${box.size.height}");
      return position;
    }
  }

  Size? _getPisteSize(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Size? size = box?.size;

    if (size != null) {
      print("size: ${size.height}");
      return size;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    print("change metrics");
  }

  @override
  Widget build(BuildContext context) {
    _runsAfterBuild();

    //dimensions écrans
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        title: 'Shot Viewer',
        home: Scaffold(
            appBar: AppBar(
              leading: BackButton(onPressed: () {
                Navigator.pop(context);
              }),
              title: const Text('SHCB Shots Viewer'),
            ),
            body: Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    key: _pisteImageKey,
                    'images/piste.svg',
                    fit: BoxFit.fill,
                    height: height,
                    //width: width,
                    //alignment: Alignment.topCenter
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  //color: Colors.amber,
                  child: pisteRendering
                      ? CustomPaint(
                          painter: OpenPainter(
                              match.getResidentstats().shoots,
                              match.getVisiteurStats().shoots,
                              pisteSize,
                              pisteOffset),
                        )
                      : Container(),
                ),
              ],
            )));
  }
}

class OpenPainter extends CustomPainter {
  List<Shoot> shcbShoots;
  List<Shoot> advShoots;
  Size? pisteSize;
  Offset? pisteOffset;

  OpenPainter(
      this.shcbShoots, this.advShoots, this.pisteSize, this.pisteOffset);

  @override
  void paint(Canvas canvas, Size size) {
    advShoots.forEach((shoot) {
      print("shoot adv, size: ${pisteSize!.height}/${pisteSize!.width}," +
          "offset: ${pisteOffset!.dx}/${pisteOffset!.dy}" +
          "shoot: ${shoot.shootPosition.x} / ${shoot.shootPosition.y}");

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

      var paint1 = Paint()..color = shootColor;
      var paint2 = Paint()..color = Colors.black;

      canvas.drawCircle(
          Offset(pisteOffset!.dx + (shoot.shootPosition.x * pisteSize!.width),
              (shoot.shootPosition.y * pisteSize!.height)),
          7,
          paint2);
      //draw points on canvas
      canvas.drawCircle(
          Offset(pisteOffset!.dx + (shoot.shootPosition.x * pisteSize!.width),
              (shoot.shootPosition.y * pisteSize!.height)),
          5,
          paint1);
    });

    shcbShoots.forEach((shoot) {
      Color shootColor;
      print("shoot res");
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

      canvas.drawCircle(
          Offset(pisteOffset!.dx + (shoot.shootPosition.x * pisteSize!.width),
              (shoot.shootPosition.y * pisteSize!.height)),
          5,
          paint1);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}