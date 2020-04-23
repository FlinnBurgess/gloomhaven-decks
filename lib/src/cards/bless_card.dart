import '../attack_modifier_result.dart';
import 'attack_modifier_card.dart';

class BlessCard extends AttackModifierCard {
  static int totalBlessCardsInPlay = 0;

  BlessCard()
      : super(doubleDamageEffect(), false, 'images/cards/base/bless.png');
}

Function(AttackModifierResult) doubleDamageEffect() {
  return (AttackModifierResult result) =>
      result.applyDamageDifference(result.totalDamage);
}
