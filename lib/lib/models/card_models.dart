import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_models.freezed.dart';
part 'card_models.g.dart';

enum CardType {
  leader, terrain, base, unit, resource, spy, intel,
}

enum ResourceType { gold, ore, wood, food, mana }  // ขยายตาม generate

@freezed
class GameCard with _$GameCard {
  const factory GameCard({
    required String id,
    required String name,
    required CardType type,
    required String ownerId,
    String? displayedOwnerId,
    @Default(false) bool isFaceUp,
    @Default(false) bool isTapped,
    ResourceType? resourceType,
    Map<String, dynamic>? effects,
    String? terrainEffect,
  }) = _GameCard;

  factory GameCard.fromJson(Map<String, dynamic> json) =>
      _$GameCardFromJson(json);
}
