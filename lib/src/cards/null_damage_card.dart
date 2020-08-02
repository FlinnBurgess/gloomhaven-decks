import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';

class NullDamageCard extends AttackModifierCard {
  NullDamageCard() : super.withLessRandomEffect(nullEffect(), minusTwoDamageEffect(), false, 'images/cards/base/null.png');
}

Function(AttackModifierResult) nullEffect() {
  return (AttackModifierResult result) {
    result.applyDamageDifference(-result.totalDamage);
    result.isNull = true;
  };
}

Function(AttackModifierResult) minusTwoDamageEffect() {
  return (AttackModifierResult result) {
    result.applyDamageDifference(-2);
    result.isNull = true;
  };
}