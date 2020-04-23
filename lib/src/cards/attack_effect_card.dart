import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';

import '../attack_modifier_result.dart';

class AttackEffectCard extends AttackModifierCard {
  AttackEffectCard(AttackEffect attackEffect, int amount, String cardImagePath)
      : super(addAttackEffect(attackEffect, amount), true, cardImagePath);
}

Function(AttackModifierResult) addAttackEffect(
    AttackEffect attackEffect, int amount) {
  return (AttackModifierResult result) =>
      result.addAttackEffect(attackEffect, amount);
}
