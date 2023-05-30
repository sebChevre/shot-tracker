import 'package:shot_tracker/model/shoot.dart';
import 'package:shot_tracker/model/shoot_position.dart';
import 'package:shot_tracker/model/shoot_type.dart';

class TeamStat {
  TeamStat({required this.shoots});

  List<Shoot> shoots;

  int goal() {
    return shoots.where((shoot) => shoot.shootType == ShootType.goal).length;
  }

  int sog() {
    return shoots.where((shoot) => shoot.shootType == ShootType.sog).length;
  }

  int miss() {
    return shoots.where((shoot) => shoot.shootType == ShootType.miss).length;
  }

  int block() {
    return shoots.where((shoot) => shoot.shootType == ShootType.block).length;
  }

  addShoot(Shoot shoot) {
    shoots.add(shoot);
  }

  removeLastShoot(ShootType shootType) {
    shoots.where((shoot) => shoot.shootType == shootType).toList().removeLast();
  }
}
