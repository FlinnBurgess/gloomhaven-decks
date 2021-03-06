import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:recase/recase.dart';

import '../attack_modifier_result.dart';

class AttackEffectCard extends AttackModifierCard {
  AttackEffectCard(AttackEffect attackEffect, int amount, String characterClass)
      : super(addAttackEffect(attackEffect, amount), true,
            generateImagePath(attackEffect, amount, characterClass));
}

String generateImagePath(
    AttackEffect effect, int amount, String characterClass) {
  characterClass = characterClass.toLowerCase();

  String effectString = effect.toString().split('.').last.paramCase;

  return 'images/cards/$characterClass/rolling-$effectString-$amount.png';
}

Function(AttackModifierResult) addAttackEffect(
    AttackEffect attackEffect, int amount) {
  return (AttackModifierResult result) =>
      result.addAttackEffect(attackEffect, amount);
}
