import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:shot_tracker/model/shoot.dart';
import 'package:shot_tracker/model/shoot_type.dart';
import 'package:shot_tracker/widget/shoot-picker.dart';
import 'package:shot_tracker/widget/shoot-position-picker.dart';
import 'package:shot_tracker/model/team-stats.dart';

void main() => runApp(ShcbStats());

class _HomePageState extends State<HomePage> {
  final TeamStat shcbStat = TeamStat(shoots: <Shoot>[]);
  final TeamStat advStat = TeamStat(shoots: <Shoot>[]);

  bool shootInTrack = false;
  bool shcbShoot = true;

  var points = <Offset>[];

  @override
  void initState() {
    super.initState();
  }

  TeamStat statsForShoot() {
    return shcbShoot ? shcbStat : advStat;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo', home: ShootPicker(shcbStat, advStat));
  }
}

class HomePage extends StatefulWidget with RouteAware {
  @override
  State<HomePage> createState() => _HomePageState();
}

class ShcbStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
