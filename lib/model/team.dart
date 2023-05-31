import '../model/shoot.dart';
import '../model/team_stats.dart';

class Team {
  Team({required this.nom, required this.nomCourt});

  final String nom;
  final String nomCourt;
  final TeamStat shcbStat = TeamStat(shoots: <Shoot>[]);

  @override
  bool operator ==(o) => o is Team && nom == o.nom && nomCourt == o.nomCourt;
  @override
  int get hashCode => Object.hash(nom, nomCourt);
}
