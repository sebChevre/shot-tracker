import 'package:flutter/material.dart';

import '../model/shoot.dart';
import '../model/shoot_type.dart';

class UiConstants {
  static const String sogLabel = "SOG";
  static const String missLabel = "MISS";
  static const String goalLabel = "GOAL";
  static const String blockLabel = "BLOCK";
  static const String shootsButtonLabel = "Shoots";

  static const TextStyle shootCounterStyle =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle shootLabelStyle =
      TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold);

  static const Color shootCounterBgd = Colors.white;

  static const TextStyle teamNomCourtLabel =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static const TextStyle teamGoalCounterLabel =
      TextStyle(fontSize: 42, fontWeight: FontWeight.bold);

  static const residentGoalColor = Colors.green;
  static const residentSogColor = Colors.red;
  static const residentMissColor = Colors.orange;
  static const residentBlockColor = Colors.blue;

  static const visiteurGoalColor = Color.fromARGB(255, 185, 236, 186);
  static const visiteurSogColor = Color.fromARGB(255, 225, 169, 165);
  static const visiteurMissColor = Color.fromARGB(255, 235, 199, 145);
  static const visiteurBlockColor = Color.fromARGB(255, 166, 198, 224);

  static colorForShot(Shoot shoot) {
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

    return shootColor;
  }
}
