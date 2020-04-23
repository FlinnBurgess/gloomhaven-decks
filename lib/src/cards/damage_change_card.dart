import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';

class DamageChangeCard extends AttackModifierCard {
  DamageChangeCard(int damageChange, String cardImagePath)
      : super(damageChangeEffect(damageChange), false, cardImagePath);

  DamageChangeCard.withInfusion(int damageChange, Infusion infusion,
      String cardImagePath)
      : super(
      damageChangeWithInfusionEffect(damageChange, infusion), false,
      cardImagePath);

  DamageChangeCard.withCondition(int damageChange, Condition condition,
      String cardImagePath)
      : super(damageChangeWithConditionEffect(damageChange, condition),
      false, cardImagePath);

  DamageChangeCard.withAttackEffect(int damageChange, AttackEffect attackEffect,
      int attackEffectAmount, String cardImagePath)
      : super(
            damageChangeWithAttackEffect(
                damageChange, attackEffect, attackEffectAmount),
      false, cardImagePath);
}

Function(AttackModifierResult) damageChangeEffect(amount) {
  return (AttackModifierResult result) => result.applyDamageDifference(amount);
}

Function(AttackModifierResult) damageChangeWithInfusionEffect(
    amount, infusion) {
  return (AttackModifierResult result) {
    result.applyDamageDifference(amount);
    result.addInfusion(infusion);
  };
}

Function(AttackModifierResult) damageChangeWithConditionEffect(
    amount, condition) {
  return (AttackModifierResult result) {
    result.applyDamageDifference(amount);
    result.addCondition(condition);
  };
}

Function(AttackModifierResult) damageChangeWithAttackEffect(
    damageChange, attackEffect, attackEffectAmount) {
  return (AttackModifierResult result) {
    result.applyDamageDifference(damageChange);
    result.addAttackEffect(attackEffect, attackEffectAmount);
  };
}
