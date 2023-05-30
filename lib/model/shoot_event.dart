import 'package:shot_tracker/model/shoot_type.dart';
import 'package:shot_tracker/model/team.dart';

class ShootEvent {
  final ShootType shootType;
  final Team team;

  ShootEvent({required this.shootType, required this.team});

  static goal(Team team) {
    return ShootEvent(shootType: ShootType.goal, team: team);
  }

  factory ShootEvent.miss(Team team) {
    return ShootEvent(shootType: ShootType.miss, team: team);
  }

  factory ShootEvent.sog(Team team) {
    return ShootEvent(shootType: ShootType.sog, team: team);
  }

  factory ShootEvent.block(Team team) {
    return ShootEvent(shootType: ShootType.block, team: team);
  }
}
