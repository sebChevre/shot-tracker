import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:shot_tracker/widget/shoot_position_picker_screen.dart';
import 'package:shot_tracker/widget/team_score_card.dart';
import '../model/match.dart' as match_lib;
import '../model/shoot_event.dart';
import '../model/versions_info.dart';
import '../service/shot_tracker_service.dart';
import '../widget/shoot_position_viewer_screen.dart';
import '../widget/ui_constants.dart';

import '../model/shoot.dart';

class MainScreen extends StatefulWidget {
  final match_lib.Match match;

  const MainScreen({super.key, required this.match});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late match_lib.Match match;

  _MainScreenState();

  @override
  void initState() {
    super.initState();
    match = widget.match;
  }

  //event click sur shoot
  onShotButtonClick(shootEvent) {
    late Shoot shootInTrack;
    shootInTrack =
        Shoot(shootType: shootEvent.shootType, team: shootEvent.team);

    _toShootPickerScreen(context, shootInTrack);
  }

  Future<void> _toShootPickerScreen(
      BuildContext context, Shoot shootInTrack) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ShootPositionPickerScreen(
              shootInTrack: shootInTrack, match: match)),
    );

    if (!mounted) return;

    Shoot shoot = result;

    setState(() {
      match.addShootForTeam(shoot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FutureBuilder(
            future: ShootTrackerService.loadVersionInfo(),
            builder: (context, AsyncSnapshot<VersionInfo> snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                    icon: const Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showAboutDialog(
                          context: context,
                          applicationIcon: FlutterLogo(),
                          applicationName: snapshot.data!.appName,
                          applicationVersion: snapshot.data!.version,
                          applicationLegalese: 'SebChevre©seb-chevre.org',
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  'Source: ${snapshot.data!.branch}',
                                  style: UiConstants.buidInfosLabel,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  'Hash: ${snapshot.data!.comitId}',
                                  style: UiConstants.buidInfosLabel,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  'BuildNo: ${snapshot.data!.buildNumber}',
                                  style: UiConstants.buidInfosLabel,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  'Time: ${snapshot.data!.time}',
                                  style: UiConstants.buidInfosLabel,
                                ))
                          ]);
                    });
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ],
        title: const Text("Shots Tracker"),
      ),
      body: Container(
          color: Colors.white,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: (1 / .5),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TeamScoreCard(
                        match: match,
                        isResident: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TeamScoreCard(
                        match: match,
                        isResident: false,
                      ),
                    ),
                    //Padding(padding: EdgeInsets.only(bottom: 30)),
                  ]),
              Expanded(
                child: GridButton(
                  onPressed: onShotButtonClick,
                  items: [
                    [
                      GridButtonItem(
                          flex: 2,
                          value: ShootEvent.sog(match.resident),
                          shape: BorderSide(
                            width: 2,
                          ),
                          borderRadius: 10,
                          child: const Text(
                            UiConstants.sogLabel,
                            style: UiConstants.shootLabelStyle,
                          ),
                          color: UiConstants.residentSogColor),
                      GridButtonItem(
                          value: ShootEvent.sog(match.resident),
                          child: Text(
                            "${match.getResidentstats().sog()}",
                            style: UiConstants.shootCounterStyle,
                          ),
                          color: UiConstants.shootCounterBgd),
                      GridButtonItem(
                          flex: 2,
                          value: ShootEvent.sog(match.visiteur),
                          shape: BorderSide(
                            width: 2,
                          ),
                          borderRadius: 10,
                          child: const Text(
                            UiConstants.sogLabel,
                            style: UiConstants.shootLabelStyle,
                          ),
                          color: UiConstants.visiteurSogColor),
                      GridButtonItem(
                          value: ShootEvent.sog(match.visiteur),
                          child: Text(
                            "${match.getVisiteurStats().sog()}",
                            style: UiConstants.shootCounterStyle,
                          ),
                          color: UiConstants.shootCounterBgd),
                    ],
                    [
                      GridButtonItem(
                          flex: 2,
                          value: ShootEvent.miss(match.resident),
                          shape: BorderSide(
                            width: 2,
                          ),
                          borderRadius: 10,
                          child: const Text(
                            UiConstants.missLabel,
                            style: UiConstants.shootLabelStyle,
                          ),
                          color: UiConstants.residentMissColor),
                      GridButtonItem(
                          value: ShootEvent.miss(match.resident),
                          child: Text(
                            "${match.getResidentstats().miss()}",
                            style: UiConstants.shootCounterStyle,
                          ),
                          color: UiConstants.shootCounterBgd),
                      GridButtonItem(
                          value: ShootEvent.miss(match.visiteur),
                          shape: BorderSide(
                            width: 2,
                          ),
                          borderRadius: 10,
                          flex: 2,
                          child: const Text(
                            UiConstants.missLabel,
                            style: UiConstants.shootLabelStyle,
                          ),
                          color: UiConstants.visiteurMissColor),
                      GridButtonItem(
                          value: ShootEvent.miss(match.visiteur),
                          child: Text(
                            "${match.getVisiteurStats().miss()}",
                            style: UiConstants.shootCounterStyle,
                          ),
                          color: UiConstants.shootCounterBgd),
                    ],
                    [
                      GridButtonItem(
                          value: ShootEvent.block(match.resident),
                          shape: BorderSide(
                            width: 2,
                          ),
                          borderRadius: 10,
                          flex: 2,
                          child: const Text(
                            UiConstants.blockLabel,
                            style: UiConstants.shootLabelStyle,
                          ),
                          color: UiConstants.residentBlockColor),
                      GridButtonItem(
                          value: ShootEvent.block(match.resident),
                          child: Text(
                            "${match.getResidentstats().block()}",
                            style: UiConstants.shootCounterStyle,
                          ),
                          color: UiConstants.shootCounterBgd),
                      GridButtonItem(
                          value: ShootEvent.block(match.visiteur),
                          shape: BorderSide(
                            width: 2,
                          ),
                          borderRadius: 10,
                          flex: 2,
                          child: const Text(
                            UiConstants.blockLabel,
                            style: UiConstants.shootLabelStyle,
                          ),
                          color: UiConstants.visiteurBlockColor),
                      GridButtonItem(
                          value: ShootEvent.block(match.visiteur),
                          child: Text(
                            "${match.getVisiteurStats().block()}",
                            style: UiConstants.shootCounterStyle,
                          ),
                          color: UiConstants.shootCounterBgd),
                    ],
                    [
                      GridButtonItem(
                          flex: 2,
                          value: ShootEvent.goal(match.resident),
                          shape: BorderSide(
                            width: 2,
                          ),
                          borderRadius: 10,
                          child: const Text(
                            UiConstants.goalLabel,
                            style: UiConstants.shootLabelStyle,
                          ),
                          color: UiConstants.residentGoalColor),
                      GridButtonItem(
                          value: ShootEvent.goal(match.resident),
                          child: Text(
                            "${match.getResidentstats().goal()}",
                            style: UiConstants.shootCounterStyle,
                          ),
                          color: UiConstants.shootCounterBgd),
                      GridButtonItem(
                          flex: 2,
                          value: ShootEvent.goal(match.visiteur),
                          shape: BorderSide(
                            width: 2,
                          ),
                          borderRadius: 10,
                          child: const Text(
                            UiConstants.goalLabel,
                            style: UiConstants.shootLabelStyle,
                          ),
                          color: UiConstants.visiteurGoalColor),
                      GridButtonItem(
                          value: ShootEvent.goal(match.visiteur),
                          child: Text(
                            "${match.getVisiteurStats().goal()}",
                            style: UiConstants.shootCounterStyle,
                          ),
                          color: UiConstants.shootCounterBgd),
                    ],
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ShootPositionViewerScreen(match: match),
                        ));
                  },
                  child: const Text(UiConstants.shootsButtonLabel))
            ],
          )),
    );
  }
}
