import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/card_models.dart';
import '../widgets/card_widget.dart';
import 'battlefield_screen.dart';

class DeckBuilderScreen extends ConsumerStatefulWidget {
  final String gameId;
  final String playerId;

  const DeckBuilderScreen({required this.gameId, required this.playerId});

  @override
  _DeckBuilderScreenState createState() => _DeckBuilderScreenState();
}

class _DeckBuilderScreenState extends ConsumerState<DeckBuilderScreen> {
  List<GameCard> allCards = [];
  List<GameCard> selectedDeck = [];

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  Future<void> loadCards() async {
    final String response = await rootBundle.loadString('assets/data/cards.json');
    final data = json.decode(response);
    setState(() {
      allCards = (data['cards'] as List).map((e) => GameCard.fromJson({
        ...e,
        'ownerId': widget.playerId,
      })).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('สร้างเด็ค')),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: allCards.length,
              itemBuilder: (_, index) {
                final card = allCards[index];
                return GestureDetector(
                  onTap: () {
                    if (!selectedDeck.contains(card) && selectedDeck.length < 30) {  // Limit เด็ค 30 ใบ
                      setState(() => selectedDeck.add(card));
                    }
                  },
                  child: CardWidget(card: card, isMine: true, currentPlayerId: widget.playerId),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: selectedDeck.length >= 20 ? () {
              // Save เด็ค to Firebase (implement in game_provider)
              ref.read(gameProvider(widget.gameId).notifier).saveDeck(widget.playerId, selectedDeck);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => BattlefieldScreen(gameId: widget.gameId, playerId: widget.playerId)),
              );
            } : null,
            child: Text('เริ่มเกม'),
          ),
        ],
      ),
    );
  }
}
