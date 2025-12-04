import 'package:riverpod/riverpod.dart';
import '../models/card_models.dart';
import '../models/game_state.dart';

final gameLogicProvider = Provider<GameLogic>((ref) => GameLogic());

class GameLogic {
  bool resolveAttack(GameCard attacker, GameCard target) {
    // Situational: เช็ค type, effects, terrain nearby
    if (attacker.type == CardType.unit && target.type == CardType.leader) {
      return true;  // ฆ่า leader ได้
    }
    // เพิ่ม logic อื่นๆ จาก spec เช่น terrain effect, spy betrayal
    // เช่น if terrain is mountain and attacker is infantry: +defense -> fail
    return randomBool();  // Placeholder
  }

  String? checkVictory(GameState state) {
    // เช็ค 7 conditions
    // 1. Leader dead
    // 2. All bases destroyed
    // etc.
    return null;  // Winner ID or null
  }
}
