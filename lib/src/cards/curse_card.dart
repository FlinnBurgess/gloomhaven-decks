import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';

import '../attack_modifier_result.dart';

class CurseCard extends AttackModifierCard {
  static int totalCurseCardsInPlay = 0;

  CurseCard() : super.withLessRandomEffect(nullEffect(), minusTwoDamageEffect(), false, 'images/cards/base/curse.png');
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
