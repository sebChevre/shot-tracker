import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import '../model/match.dart' as match_lib;
import '../model/shoot_event.dart';
import '../widget/shoot_position_viewer_screen.dart';
import '../widget/ui_constants.dart';

import '../model/shoot.dart';

class MainScreen extends StatefulWidget {
  final match_lib.Match match;
  final shootCallBack;

  const MainScreen(
      {super.key, required this.match, required this.shootCallBack});

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

  dealButtonClick(shootEvent) {
    late Shoot shootInTrack;

    shootInTrack =
        Shoot(shootType: shootEvent.shootType, team: shootEvent.team);

    widget.shootCallBack(shootInTrack);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[300],
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: (1 / .2),
                children: [
                  Container(
                    color: Colors.lightBlue,
                    child: Text(
                      match.resident.nomCourt,
                      style: UiConstants.teamNomCourtLabel,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    match.visiteur.nomCourt,
                    style: UiConstants.teamNomCourtLabel,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    color: Colors.lightBlue,
                    child: Text(
                      "${match.getResidentstats().goal()}",
                      style: UiConstants.teamGoalCounterLabel,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "${match.getVisiteurStats().goal()}",
                    style: UiConstants.teamGoalCounterLabel,
                    textAlign: TextAlign.center,
                  )
                ]),
            Expanded(
              child: GridButton(
                onPressed: dealButtonClick,
                items: [
                  [
                    GridButtonItem(
                        flex: 2,
                        value: ShootEvent.sog(match.resident),
                        child: const Text(
                          UiConstants.sogLabel,
                          style: UiConstants.shootLabelStyle,
                        ),
                        color: UiConstants.residentSogColor),
                    GridButtonItem(
                        child: Text(
                          "${match.getResidentstats().sog()}",
                          style: UiConstants.shootCounterStyle,
                        ),
                        color: UiConstants.shootCounterBgd),
                    GridButtonItem(
                        flex: 2,
                        value: ShootEvent.sog(match.visiteur),
                        child: const Text(
                          UiConstants.sogLabel,
                          style: UiConstants.shootLabelStyle,
                        ),
                        color: UiConstants.visiteurSogColor),
                    GridButtonItem(
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
                        child: const Text(
                          UiConstants.missLabel,
                          style: UiConstants.shootLabelStyle,
                        ),
                        color: UiConstants.residentMissColor),
                    GridButtonItem(
                        child: Text(
                          "${match.getResidentstats().miss()}",
                          style: UiConstants.shootCounterStyle,
                        ),
                        color: UiConstants.shootCounterBgd),
                    GridButtonItem(
                        value: ShootEvent.miss(match.visiteur),
                        flex: 2,
                        child: const Text(
                          UiConstants.missLabel,
                          style: UiConstants.shootLabelStyle,
                        ),
                        color: UiConstants.visiteurMissColor),
                    GridButtonItem(
                        child: Text(
                          "${match.getVisiteurStats().miss()}",
                          style: UiConstants.shootCounterStyle,
                        ),
                        color: UiConstants.shootCounterBgd),
                  ],
                  [
                    GridButtonItem(
                        value: ShootEvent.block(match.resident),
                        flex: 2,
                        child: const Text(
                          UiConstants.blockLabel,
                          style: UiConstants.shootLabelStyle,
                        ),
                        color: UiConstants.residentBlockColor),
                    GridButtonItem(
                        child: Text(
                          "${match.getResidentstats().block()}",
                          style: UiConstants.shootCounterStyle,
                        ),
                        color: UiConstants.shootCounterBgd),
                    GridButtonItem(
                        value: ShootEvent.block(match.visiteur),
                        flex: 2,
                        child: const Text(
                          UiConstants.blockLabel,
                          style: UiConstants.shootLabelStyle,
                        ),
                        color: UiConstants.visiteurBlockColor),
                    GridButtonItem(
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
                        child: const Text(
                          UiConstants.goalLabel,
                          style: UiConstants.shootLabelStyle,
                        ),
                        color: UiConstants.residentGoalColor),
                    GridButtonItem(
                        child: Text(
                          "${match.getResidentstats().goal()}",
                          style: UiConstants.shootCounterStyle,
                        ),
                        color: UiConstants.shootCounterBgd),
                    GridButtonItem(
                        flex: 2,
                        value: ShootEvent.goal(match.visiteur),
                        child: const Text(
                          UiConstants.goalLabel,
                          style: UiConstants.shootLabelStyle,
                        ),
                        color: UiConstants.visiteurGoalColor),
                    GridButtonItem(
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
        ));
  }
}
