import 'package:flutter/material.dart';
import 'package:shot_tracker/model/team.dart';
import 'package:shot_tracker/widget/shoot-picker.dart';
import 'package:shot_tracker/model/match.dart' as match_lib;

void main() => runApp(const ShcbStats());

class _HomePageState extends State<HomePage> {
  /// * INITIAL STATE
  final match_lib.Match match = match_lib.Match(
      resident: Team(nom: "SHC Bassecourt", nomCourt: "SHCB"),
      visiteur: Team(nom: "Visiteur", nomCourt: "VIS"));

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
