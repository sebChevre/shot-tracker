import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widget/utils.dart';
import '../model/match.dart';
import '../painter/shoot_point_painter.dart';
import '../model/match.dart' as match_lib;

import '../model/shoot.dart';
import '../painter/team_text_painter.dart';

class ShootPositionPickerScreen extends StatefulWidget {
  const ShootPositionPickerScreen(
      {super.key, required this.shootInTrack, required this.match});

  final Shoot shootInTrack;
  final Match match;

  @override
  State<ShootPositionPickerScreen> createState() =>
      _ShootPositionPickerScreenState();
}

class _ShootPositionPickerScreenState extends State<ShootPositionPickerScreen> {
  _ShootPositionPickerScreenState();

  final GlobalKey _pisteImageKey = GlobalKey();

  List<Offset> _shootPoints = [];
  late Shoot shootInTrack;
  late match_lib.Match match;
  bool pisteRendering = false;
  late Offset pisteOffset;
  late Size pisteSize;

  @override
  void initState() {
    super.initState();
    match = widget.match;
    shootInTrack = widget.shootInTrack;
  }

  void _postFrameCallback(_) {
    setState(() {
      pisteOffset = Utils.getPisteOffset(_pisteImageKey)!;
      pisteSize = Utils.getPisteSize(_pisteImageKey)!;
      pisteRendering = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(_postFrameCallback);

    //dimensions écrans
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context, shootInTrack);
        }),
      ),
      body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(children: [
              CustomPaint(
                painter: ShootPointPainter(Utils.getPisteOffset(_pisteImageKey),
                    _shootPoints, shootInTrack),
              ),
              Container(
                  child: pisteRendering
                      ? CustomPaint(
                          painter: TextTeamsPainter(
                              pisteSize: pisteSize, match: match),
                        )
                      : Container()),
              GestureDetector(
                child: SvgPicture.asset(
                  'images/piste.svg',
                  key: _pisteImageKey,
                  height: height,
                  fit: BoxFit.fill,
                  width: width,
                ),
                onTapDown: (details) {
                  _shootPoints = [];

                  final localTapPosition = details.localPosition;

                  final x = localTapPosition.dx;
                  final y = localTapPosition.dy;

                  final globalTapPosition = details.globalPosition;
                  final xg = globalTapPosition.dx;
                  final yg = globalTapPosition.dy;

                  setState(() {
                    _shootPoints.add(Offset(x, y));

                    shootInTrack.addShootPosition(
                        x / Utils.getPisteSize(_pisteImageKey)!.width,
                        y / Utils.getPisteSize(_pisteImageKey)!.height);
                  });
                },
              ),
            ]),
          ]),
    );
  }
}
