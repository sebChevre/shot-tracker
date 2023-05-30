import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shot_tracker/painter/shoots_view_painter.dart';

import '../model/shoot.dart';
import '../model/match.dart' as match_lib;
import '../painter/team_text_painter.dart';

class ShootPositionViewerScreen extends StatefulWidget {
  const ShootPositionViewerScreen({super.key, required this.match});

  final match_lib.Match match;

  @override
  State<ShootPositionViewerScreen> createState() =>
      _ShootPositionViewerScreenState();
}

class _ShootPositionViewerScreenState extends State<ShootPositionViewerScreen>
    with WidgetsBindingObserver {
  _ShootPositionViewerScreenState();

  late match_lib.Match match;
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

  Offset? _getPisteOffset(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);

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

  @override
  void initState() {
    super.initState();
    match = widget.match;
  }

  @override
  void didChangeMetrics() {
    print("change metrics");
  }

  void _postFrameCallback(_) {
    setState(() {
      pisteOffset = _getPisteOffset(_pisteImageKey)!;
      pisteSize = _getPisteSize(_pisteImageKey)!;
      pisteRendering = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(_postFrameCallback);

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
              title: const Text('Shots Viewer'),
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Container(
                        child: pisteRendering
                            ? CustomPaint(
                                painter: TextTeamsPainter(
                                    pisteSize: pisteSize, match: match),
                              )
                            : Container()),
                    SvgPicture.asset(
                      key: _pisteImageKey,
                      'images/piste.svg',
                      fit: BoxFit.fill,
                      height: height,
                      width: width,
                      //alignment: Alignment.topCenter
                    ),
                    Container(
                      //color: Colors.amber,
                      child: pisteRendering
                          ? CustomPaint(
                              painter: ShootsViewPainter(
                                  match.getResidentstats().shoots,
                                  match.getVisiteurStats().shoots,
                                  pisteSize,
                                  pisteOffset),
                            )
                          : Container(),
                    ),
                  ],
                )
              ],
            )));
  }
}
