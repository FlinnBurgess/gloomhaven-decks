import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';

class DoubleDamageCard extends AttackModifierCard {
  DoubleDamageCard()
      : super(doubleDamageEffect(), false, 'cards/base/double-damage.png');
}

Function(AttackModifierResult) doubleDamageEffect() {
  return (AttackModifierResult result) =>
      result.applyDamageDifference(result.totalDamage);
}
