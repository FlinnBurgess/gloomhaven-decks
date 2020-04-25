import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';

import '../attack_modifier_result.dart';

class AttackEffectCard extends AttackModifierCard {
  AttackEffectCard(AttackEffect attackEffect, int amount, String characterClass)
      : super(addAttackEffect(attackEffect, amount), true,
      generateImagePath(attackEffect, amount, characterClass));
}

String generateImagePath(AttackEffect effect, int amount,
    String characterClass) {
  characterClass = characterClass.toLowerCase();
  String effectString = effect == AttackEffect.addTarget
      ? 'add-target'
      : effect.toString().toLowerCase();

  return 'images/cards/$characterClass/rolling-$effectString-$amount.png';
}

Function(AttackModifierResult) addAttackEffect(
    AttackEffect attackEffect, int amount) {
  return (AttackModifierResult result) =>
      result.addAttackEffect(attackEffect, amount);
}
