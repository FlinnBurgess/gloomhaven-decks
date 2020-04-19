import 'package:gloomhaven_decks/src/attack_modifier_result.dart';

abstract class AttackModifierCard {
  Function(AttackModifierResult) effect;
  bool isRolling;

  AttackModifierCard(this.effect, this.isRolling);

  AttackModifierResult applyEffect(AttackModifierResult result) {
    effect(result);
    return result;
  }

  List<AttackModifierCard> times(int count) {
    var listOfCards = [];
    for (int i = 0; i < count; i++) {
      listOfCards.add(this);
    }
    return listOfCards;
  }
}
