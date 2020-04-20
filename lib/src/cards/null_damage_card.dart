import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';

class NullDamageCard extends AttackModifierCard {
  NullDamageCard() : super(nullEffect(), false);
}

Function(AttackModifierResult) nullEffect() {
  return (AttackModifierResult result) {
    result.totalDamage = 0;
    result.isNull = true;
  };
}
