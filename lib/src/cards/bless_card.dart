import '../attack_modifier_result.dart';
import 'attack_modifier_card.dart';

class BlessCard extends AttackModifierCard {
  static int totalBlessCardsInPlay = 0;

  BlessCard()
      : super.withLessRandomEffect(doubleDamageEffect(), plusTwoDamageEffect(), false, 'images/cards/base/bless.png');
}

Function(AttackModifierResult) doubleDamageEffect() {
  return (AttackModifierResult result) {
    result.applyDamageDifference(result.totalDamage);
  };
}

Function(AttackModifierResult) plusTwoDamageEffect() {
  return (AttackModifierResult result) {
    result.applyDamageDifference(2);
  };
}
