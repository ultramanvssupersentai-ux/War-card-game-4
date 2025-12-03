import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../providers/game_provider.dart';
import 'deck_builder_screen.dart';

class LobbyScreen extends ConsumerWidget {
  final _gameIdController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Lobby')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final gameId = Uuid().v4();
                ref.read(gameProvider(gameId).notifier).createGame(gameId);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DeckBuilderScreen(gameId: gameId, playerId: 'player1')),
                );
              },
              child: Text('สร้างห้องใหม่'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _gameIdController,
              decoration: InputDecoration(labelText: 'รหัสห้อง'),
            ),
            ElevatedButton(
              onPressed: () {
                final gameId = _gameIdController.text;
                if (gameId.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DeckBuilderScreen(gameId: gameId, playerId: 'player2')),
                  );
                }
              },
              child: Text('เข้าห้อง'),
            ),
          ],
        ),
      ),
    );
  }
}
