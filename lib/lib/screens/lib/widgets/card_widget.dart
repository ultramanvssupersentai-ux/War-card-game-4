// lib/widgets/card_widget.dart
class CardWidget extends ConsumerWidget {
  final GameCard card;
  final bool isMine;
  final String currentPlayerId;

  const CardWidget({
    required this.card,
    required this.isMine,
    required this.currentPlayerId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool canSeeFace = isMine ||
        card.isFaceUp ||
        card.type == CardType.resource; // ทรัพยากรเห็นหน้าเสมอ

    return GestureDetector(
      onTap: () {
        // คลิกเลือกการ์ดเพื่อโจมตี / ใช้ความสามารถ
        ref.read(selectedCardProvider.notifier).state = card;
      },
      child: Container(
        width: 90,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: card.ownerId == currentPlayerId ? Colors.blue : Colors.red,
            width: 3,
          ),
        ),
        child: canSeeFace
            ? _buildFace(card)
            : _buildBack(), // คว่ำหน้า
      ),
    );
  }

  Widget _buildFace(GameCard card) {
    Color bgColor = switch (card.type) {
      CardType.leader => Colors.purple,
      CardType.terrain => Colors.brown,
      CardType.base => Colors.grey[800]!,
      CardType.unit => Colors.green,
      CardType.spy => Colors.black,
      CardType.intel => Colors.orange,
      CardType.resource => Colors.amber,
    };

    return Stack(
      children: [
        Container(color: bgColor.withOpacity(0.9)),
        Center(
          child: Text(
            card.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        if (card.isTapped)
          Transform.rotate(
            angle: 1.57, // 90 องศา
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
      ],
    );
  }

  Widget _buildBack() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(Icons.help_outline, size: 50, color: Colors.white),
      ),
    );
  }
}
