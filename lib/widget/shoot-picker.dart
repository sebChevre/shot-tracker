import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:shot_tracker/widget/shoot-position-picker.dart';
import 'package:shot_tracker/widget/shoot-position-viewer.dart';

import '../model/shoot.dart';
import '../model/shoot_type.dart';
import '../model/team-stats.dart';
import '../model/match.dart' as match_lib;

class ShootPicker extends StatefulWidget {
  match_lib.Match match;

  ShootPicker(this.match);

  @override
  State<ShootPicker> createState() => _ShootPickerState(match);
}

class _ShootPickerState extends State<ShootPicker> {
  _ShootPickerState(this.match);

  match_lib.Match match;
  bool isShootInTrack = false;
  bool isShcbShoot = true;
  late Shoot shootInTrack;

  dealButtonClick(value) {
    print(value);

    setState(() {
      switch (value) {
        case "shcb-goal":
          {
            shootInTrack =
                Shoot(shootType: ShootType.goal, team: match.getResident());
          }
          break;

        case "shcb-sog":
          {
            shootInTrack =
                Shoot(shootType: ShootType.sog, team: match.getResident());
          }
          break;

        case "shcb-miss":
          {
            shootInTrack =
                Shoot(shootType: ShootType.miss, team: match.getResident());
          }
          break;

        case "shcb-block":
          {
            shootInTrack =
                Shoot(shootType: ShootType.block, team: match.getResident());
          }
          break;

        case "adv-goal":
          {
            shootInTrack =
                Shoot(shootType: ShootType.goal, team: match.getVisiteur());
          }
          break;

        case "adv-sog":
          {
            shootInTrack =
                Shoot(shootType: ShootType.sog, team: match.getVisiteur());
          }
          break;

        case "adv-miss":
          {
            shootInTrack =
                Shoot(shootType: ShootType.miss, team: match.getVisiteur());
          }
          break;

        case "adv-block":
          {
            shootInTrack =
                Shoot(shootType: ShootType.block, team: match.getVisiteur());
          }
          break;
      }
      isShootInTrack = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //dimensions écrans
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
        title: 'Shot Picker',
        home: Scaffold(
            appBar: AppBar(
              leading: isShootInTrack
                  ? BackButton(
                      onPressed: () {
                        setState(() {
                          isShootInTrack = false;

                          print("ShootInTrack ${shootInTrack.shootPosition.x}");
                          match.addShootForTeam(
                              shootInTrack.team, shootInTrack);
                        });
                      },
                    )
                  : Container(),
              title: Text('SHCB Shots Trackers'),
            ),
            body: isShootInTrack
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ShootPositionPicker(shootInTrack: shootInTrack),
                    ],
                  )
                : Container(
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
                                child: const Text(
                                  "SHCB",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Text(
                                "Adversaire",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                color: Colors.lightBlue,
                                child: Text(
                                  "${match.getResidentstats().goal()}",
                                  style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                "${match.getVisiteurStats().goal()}",
                                style: TextStyle(
                                    fontSize: 42, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            ]),
                        Expanded(
                          child: GridButton(
                            onPressed: dealButtonClick,
                            items: [
                              [
                                const GridButtonItem(
                                    flex: 2,
                                    value: "shcb-sog",
                                    child: Text(
                                      "SOG",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.red),
                                GridButtonItem(
                                    child: Text(
                                      "${match.getResidentstats().sog()}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white),
                                GridButtonItem(
                                    flex: 2,
                                    value: "adv-sog",
                                    child: Text(
                                      "SOG",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Color.fromARGB(255, 225, 169, 165)),
                                GridButtonItem(
                                    value: "adv-sog",
                                    child: Text(
                                      "${match.getVisiteurStats().sog()}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white),
                              ],
                              [
                                GridButtonItem(
                                    flex: 2,
                                    value: "shcb-miss",
                                    child: Text(
                                      "MISS",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.orange),
                                GridButtonItem(
                                    value: "shcb-miss",
                                    child: Text(
                                      "${match.getResidentstats().miss()}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white),
                                GridButtonItem(
                                    value: "adv-miss",
                                    flex: 2,
                                    child: Text(
                                      "MISS",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Color.fromARGB(255, 235, 199, 145)),
                                GridButtonItem(
                                    value: "adv-miss",
                                    child: Text(
                                      "${match.getVisiteurStats().miss()}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white),
                              ],
                              [
                                GridButtonItem(
                                    value: "shcb-block",
                                    flex: 2,
                                    child: Text(
                                      "BLOCK",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.blue),
                                GridButtonItem(
                                    value: "shcb-block",
                                    child: Text(
                                      "${match.getResidentstats().block()}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white),
                                GridButtonItem(
                                    value: "adv-block",
                                    flex: 2,
                                    child: Text(
                                      "BLOCK",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Color.fromARGB(255, 166, 198, 224)),
                                GridButtonItem(
                                    value: "adv-block",
                                    child: Text(
                                      "${match.getVisiteurStats().block()}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white),
                              ],
                              [
                                const GridButtonItem(
                                    flex: 2,
                                    value: "shcb-goal",
                                    child: Text(
                                      "GOAL",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.green),
                                GridButtonItem(
                                    value: "shcb-goal",
                                    child: Text(
                                      "${match.getResidentstats().goal()}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white),
                                const GridButtonItem(
                                    flex: 2,
                                    value: "adv-goal",
                                    child: Text(
                                      "GOAL",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.green),
                                GridButtonItem(
                                    value: "adv-goal",
                                    child: Text(
                                      "${match.getVisiteurStats().goal()}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.white),
                              ],
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShootPositionViewer(match: match)));

                              /*
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                                height: height,
                                                width: width,
                                                child: Center(
                                                  child: ShootPositionViewer(
                                                      match: match),
                                                ))
                                          ])));
                                          */
                            },
                            child: Text('Shoots'))
                      ],
                    ))));
  }
}
