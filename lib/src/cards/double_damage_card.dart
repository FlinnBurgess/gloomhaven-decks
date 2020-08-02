import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';

class DoubleDamageCard extends AttackModifierCard {
  DoubleDamageCard()
      : super.withLessRandomEffect(
      doubleDamageEffect(), plusTwoDamageEffect(), false, 'images/cards/base/double-damage.png');
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
