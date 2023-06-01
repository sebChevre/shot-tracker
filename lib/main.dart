import 'package:flutter/material.dart';
import '../model/team.dart';
import '../widget/main_screen.dart';
import '../model/match.dart' as match_lib;

void main() => runApp(Main());

class Main extends StatelessWidget with RouteAware {
  final match_lib.Match match = match_lib.Match(
      resident: Team(nom: "SHC Bassecourt", nomCourt: "SHCB"),
      visiteur: Team(nom: "Visiteur", nomCourt: "VIS"));

  Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Shot Tracker', home: MainScreen(match: match));
  }
}
