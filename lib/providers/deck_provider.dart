import 'package:riverpod/riverpod.dart';

final deckProvider = Provider<List<GameCard>>((ref) {
  // Load from JSON if needed
  return [];
});
