import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../actors/leena.dart';
import '../main.dart';
import 'package:tiled/tiled.dart';

class Gem extends SpriteComponent
    with CollisionCallbacks, HasGameRef<LeenaGame> {
  final TiledObject tiledObject;
  Gem({required this.tiledObject}) : super() {
    debugMode = false;
  }

  @override
  Future<void>? onLoad() async {
    add(RectangleHitbox());
    print(tiledObject.type);
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print('hit gem');
    if (other is Leena) {
      gameRef.gems.remove(this);
      removeFromParent();
      gameRef.bonus.start();
      gameRef.magicLevel += 1;
      gameRef.overlays.notifyListeners();
    }

    super.onCollision(intersectionPoints, other);
  }
}
