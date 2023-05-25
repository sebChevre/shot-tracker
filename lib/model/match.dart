import 'package:shot_tracker/model/shoot.dart';
import 'package:shot_tracker/model/shoot_position.dart';
import 'package:shot_tracker/model/shoot_type.dart';
import 'package:shot_tracker/model/team-stats.dart';
import 'package:shot_tracker/model/team.dart';
import 'package:shot_tracker/model/team.dart';

class Match {
  Match({required this.resident, required this.visiteur});

  final Team resident;
  final Team visiteur;

  final TeamStat residentStats = TeamStat(shoots: <Shoot>[]);
  final TeamStat visiteurStats = TeamStat(shoots: <Shoot>[]);

  Team getResident() {
    return resident;
  }

  Team getVisiteur() {
    return visiteur;
  }

  TeamStat getResidentstats() {
    return residentStats;
  }

  TeamStat getVisiteurStats() {
    return visiteurStats;
  }

  addShootForTeam(Team team, Shoot shoot) {
    if (team == resident) {
      residentStats.addShoot(shoot);
    } else {
      visiteurStats.addShoot(shoot);
    }
  }
}
