import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';

class DamageChangeCard extends AttackModifierCard {
  DamageChangeCard(int damageChange)
      : super(damageChangeEffect(damageChange), false);

  DamageChangeCard.withInfusion(int damageChange, Infusion infusion)
      : super(
      damageChangeWithInfusionEffect(damageChange, infusion), false);

  DamageChangeCard.withCondition(int damageChange, Condition condition)
      : super(damageChangeWithConditionEffect(damageChange, condition),
      false);

  DamageChangeCard.withAttackEffect(int damageChange, AttackEffect attackEffect,
      int attackEffectAmount)
      : super(
            damageChangeWithAttackEffect(
                damageChange, attackEffect, attackEffectAmount),
      false);
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
