import 'package:freezed_annotation/freezed_annotation.dart';
import 'card_models.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

enum GamePhase { setup, planning, battle, end }

@freezed
class GameState with _$GameState {
  const factory GameState({
    required String gameId,
    required String currentTurnPlayerId,
    required List<GameCard> battlefield,
    required Map<String, List<GameCard>> playerHands,
    required Map<String, List<GameCard>> playerResources,
    required Map<String, bool> playerReady,
    String? winnerId,
    @Default(GamePhase.setup) GamePhase phase,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);
}
