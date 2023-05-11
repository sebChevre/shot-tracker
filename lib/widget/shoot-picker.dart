import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:shot_tracker/widget/shoot-position-picker.dart';
import 'package:shot_tracker/widget/shoot-position-viewer.dart';

import '../model/shoot.dart';
import '../model/shoot_type.dart';
import '../model/team-stats.dart';

class ShootPicker extends StatefulWidget {
  TeamStat shcbStat;
  TeamStat advStat;

  ShootPicker(this.shcbStat, this.advStat);

  @override
  State<ShootPicker> createState() => _ShootPickerState(shcbStat, advStat);
}

class _ShootPickerState extends State<ShootPicker> {
  _ShootPickerState(this.shcbStat, this.advStat);

  TeamStat shcbStat;
  TeamStat advStat;

  bool isShootInTrack = false;
  bool isShcbShoot = true;

  late Shoot shootInTrack;

  void setShot(Offset shootPosition) {
    setState(() {
      //isShootInTrack = false;
      shootInTrack.addShootPosition(shootPosition.dx, shootPosition.dy);

      isShcbShoot
          ? shcbStat.addShoot(shootInTrack)
          : advStat.addShoot(shootInTrack);
    });
  }

  dealButtonClick(value) {
    print(value);

    setState(() {
      switch (value) {
        case "shcb-goal":
          {
            isShcbShoot = true;
            shootInTrack = Shoot(shootType: ShootType.goal);
          }
          break;

        case "shcb-sog":
          {
            isShcbShoot = true;
            shootInTrack = Shoot(shootType: ShootType.sog);
          }
          break;

        case "shcb-miss":
          {
            isShcbShoot = true;
            shootInTrack = Shoot(shootType: ShootType.miss);
          }
          break;

        case "shcb-block":
          {
            isShcbShoot = true;
            shootInTrack = Shoot(shootType: ShootType.block);
          }
          break;

        case "adv-goal":
          {
            isShcbShoot = false;
            shootInTrack = Shoot(shootType: ShootType.goal);
          }
          break;

        case "adv-sog":
          {
            isShcbShoot = false;
            shootInTrack = Shoot(shootType: ShootType.sog);
          }
          break;

        case "adv-miss":
          {
            isShcbShoot = false;
            shootInTrack = Shoot(shootType: ShootType.miss);
          }
          break;

        case "adv-block":
          {
            isShcbShoot = false;
            shootInTrack = Shoot(shootType: ShootType.block);
          }
          break;
      }
      isShootInTrack = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shot Picker',
        home: Scaffold(
            appBar: AppBar(
              leading: isShootInTrack
                  ? BackButton(
                      onPressed: () {
                        setState(() {
                          isShootInTrack = false;
                        });
                      },
                    )
                  : Container(),
              title: Text('SHCB Shots Trackers'),
            ),
            body: isShootInTrack
                ? ShootPositionPicker(
                    setShot: setShot,
                    shootInTrack: shootInTrack,
                    isShcbShoot: isShcbShoot)
                : Container(
                    //color: Colors.grey[300],
                    width: double.infinity,
                    height: 400,
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
                                  "${shcbStat.goal()}",
                                  style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                "${advStat.goal()}",
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
                                      "${shcbStat.sog()}",
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
                                      "${advStat.sog()}",
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
                                      "${shcbStat.miss()}",
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
                                      "${advStat.miss()}",
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
                                      "${shcbStat.block()}",
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
                                      "${advStat.block()}",
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
                                      "${shcbStat.goal()}",
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
                                      "${advStat.goal()}",
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShootPositionViewer(
                                      shcbStat: shcbStat, advStat: advStat)));
                            },
                            child: Text('Shoots'))
                      ],
                    ))));
  }
}
