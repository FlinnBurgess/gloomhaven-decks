import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';

class DoubleDamageCard extends AttackModifierCard {
  DoubleDamageCard() : super(doubleDamageEffect(), false);
}

Function(AttackModifierResult) doubleDamageEffect() {
  return (AttackModifierResult result) =>
      result.applyDamageDifference(result.attackModification);
}
