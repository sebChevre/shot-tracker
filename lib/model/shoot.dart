import '../model/shoot_position.dart';
import '../model/shoot_type.dart';
import '../model/team.dart';

class Shoot {
  Shoot({required this.shootType, required this.team});

  ShootType shootType;
  Team team;
  bool positionDefined = false;

  late ShootPosition shootPosition;

  addShootPosition(x, y) {
    shootPosition = ShootPosition(x: x, y: y);
    positionDefined = true;
  }

  ShootPosition getShootPosition() {
    return shootPosition;
  }
}
