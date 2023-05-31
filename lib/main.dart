import 'package:flutter/material.dart';
import 'package:shot_tracker/model/team.dart';
import 'package:shot_tracker/widget/shoot_picker_app.dart';
import 'package:shot_tracker/model/match.dart' as match_lib;

void main() => runApp(Main());

class Main extends StatelessWidget with RouteAware {
  final match_lib.Match match = match_lib.Match(
      resident: Team(nom: "SHC Bassecourt", nomCourt: "SHCB"),
      visiteur: Team(nom: "Visiteur", nomCourt: "VIS"));

  Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Shot Tracker', home: ShootPickerApp(match));
  }
}
