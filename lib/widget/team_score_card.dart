import 'package:flutter/material.dart';
import 'package:shot_tracker/widget/ui_constants.dart';
import '../model/match.dart' as match_lib;

class TeamScoreCard extends StatelessWidget {
  match_lib.Match match;

  bool isResident;

  TeamScoreCard({super.key, required this.match, required this.isResident});

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.lightBlue,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isResident ? match.resident.nomCourt : match.visiteur.nomCourt,
              style: UiConstants.teamNomCourtLabel,
              textAlign: TextAlign.center,
            ),
            Text(
              isResident
                  ? "${match.getResidentstats().goal()}"
                  : "${match.getVisiteurStats().goal()}",
              style: UiConstants.teamGoalCounterLabel,
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
