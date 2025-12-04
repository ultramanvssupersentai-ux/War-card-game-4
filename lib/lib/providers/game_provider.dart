import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import '../models/game_state.dart';

final gameProvider = StateNotifierProvider.family<GameNotifier, AsyncValue<GameState>, String>((ref, gameId) {
  return GameNotifier(gameId);
});

class GameNotifier extends StateNotifier<AsyncValue<GameState>> {
  final String gameId;
  GameNotifier(this.gameId) : super(AsyncLoading()) {
    _load();
  }

  void _load() {
    FirebaseFirestore.instance.collection('games').doc(gameId).snapshots().listen((snap) {
      if (snap.exists) {
        state = AsyncData(GameState.fromJson(snap.data()!));
      }
    });
  }

  void createGame(String gameId) {
    FirebaseFirestore.instance.collection('games').doc(gameId).set(GameState(
      gameId: gameId,
      currentTurnPlayerId: 'player1',
      battlefield: [],
      playerHands: {},
      playerResources: {},
      playerReady: {},
    ).toJson());
  }

  void saveDeck(String playerId, List<GameCard> deck) {
    // Implement: update playerHands[playerId] = deck
  }

  void endTurn() {
    // Switch turn, check victory
  }

  // Add summon, attack methods
}
