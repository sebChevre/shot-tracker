import 'package:shot_tracker/model/shoot_position.dart';
import 'package:shot_tracker/model/shoot_type.dart';

class Shoot {
  Shoot({required this.shootType});

  ShootType shootType;
  late ShootPosition shootPosition;

  addShootPosition(x, y) {
    shootPosition = ShootPosition(x: x, y: y);
  }

  ShootPosition getShootPosition() {
    return shootPosition;
  }
}
