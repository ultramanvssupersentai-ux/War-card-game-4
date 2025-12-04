// (เหมือนก่อนหน้า) แต่เพิ่ม method ใน class
// เช่น onAttack:
void _attack(GameCard attacker, GameCard target, WidgetRef ref) {
  // Situational attack: เช็ค effects, terrain, etc.
  bool success = ref.read(gameLogicProvider).resolveAttack(attacker, target);
  if (success) {
    // Remove target from battlefield
  }
  // Update Firebase
}
