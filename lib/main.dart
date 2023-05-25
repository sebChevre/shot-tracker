import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:shot_tracker/model/shoot.dart';
import 'package:shot_tracker/model/shoot_type.dart';
import 'package:shot_tracker/model/team.dart';
import 'package:shot_tracker/widget/shoot-picker.dart';
import 'package:shot_tracker/widget/shoot-position-picker.dart';
import 'package:shot_tracker/model/team-stats.dart';
import 'package:shot_tracker/model/match.dart' as match_lib;

void main() => runApp(ShcbStats());

class _HomePageState extends State<HomePage> {
  /*** INITIAL STATE */

  final match_lib.Match match = match_lib.Match(
      resident: Team(nom: "SHC Bassecourt", nomCourt: "SHCB"),
      visiteur: Team(nom: "Visiteur", nomCourt: "VIS"));

  //final TeamStat shcbStat = TeamStat(shoots: <Shoot>[]);
  //final TeamStat advStat = TeamStat(shoots: <Shoot>[]);

  bool shootInTrack = false;
  bool shcbShoot = true;

  var points = <Offset>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Shot Stats App', home: ShootPicker(match));
  }
}

class HomePage extends StatefulWidget with RouteAware {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class ShcbStats extends StatelessWidget {
  const ShcbStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}
